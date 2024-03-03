#include "DetectNode.hpp"
#include "cv_bridge/cv_bridge.h"
#include <cmath>
#include <vector>
#define PI 3.1415926
const double g = 9.81;               // 重力加速度 m/s^2
const double rho = 1.204;            // 空气密度 kg/m^3
const double mu = 1.825e-5;          // 空气动力粘度 kg/(m·s)
const double diameter_large = 0.042; // 大球直径 m
const double diameter_small = 0.017; // 小球直径 m
double v0 = 30.0;                    // 发射速度 m/s，示例值
double target_distance;              // 目标相对于发射点距离需要传入
double x0;                           // 目标相对于发射点直线地面距离 需要传入
double z0;                           // 目标相对于发射点高度距离 需要传入
double lambda_large;
double lambda_small;
std::vector<double> smallA;
std::vector<double> largeA;
double findValue(const std::vector<double> &vec)
{
    if (!vec.empty())
    {
        // 查找是否有负值
        auto it = std::find_if(vec.begin(), vec.end(), [](double value)
                               { return value < 0.0; });
        // 如果找到负值，则返回它
        if (it != vec.end())
        {
            return *it;
        }
        // 如果没有负值，找到最小的正值
        else
        {
            double minPositive = std::numeric_limits<double>::max();
            for (double num : vec)
            {
                if (num > 0.0 && num < minPositive)
                {
                    minPositive = num;
                }
            }
            // 如果找到正值，返回它，否则返回最大double值表示没有找到正值
            return minPositive != std::numeric_limits<double>::max() ? minPositive : -1;
        }
    }
    else
        return -1;
}
// 计算雷诺数的函数
double calculateReynoldsNumber(double diameter)
{
    return (rho * v0 * diameter) / mu;
}

// 计算阻力系数的函数
double calculateDragCoefficient(double reynolds_number)
{
    // 根据雷诺数和给定的关系来计算阻力系数C
    if (reynolds_number < 2000)
    {
        return 24 / reynolds_number; // 层流情况下的阻力系数
    }
    else
    {
        return 0.5; //  根据情况调参
    }
}
// f(t) 函数
double f(double t, double lambda, int flag)
{
    return (g / lambda) * (std::log(1 - lambda * t) / lambda + t) + flag * std::sqrt(v0 * v0 * t * t - x0 * x0) - z0;
}

// f'(t) 函数
double f_prime(double t, double lambda, int flag)
{
    return flag * v0 * v0 * t / std::sqrt(v0 * v0 * t * t - x0 * x0) - g * t / (1 - lambda * t);
}

// 牛顿迭代法求解 t
double newtonRaphson(double initial_guess, double lambda, int flag)
{
    double t = initial_guess;
    double h = f(t, lambda, flag) / f_prime(t, lambda, flag);

    while (std::abs(h) > std::numeric_limits<double>::epsilon())
    {
        h = f(t, lambda, flag) / f_prime(t, lambda, flag);
        t -= h;
        // 如果新的 t 导致在根号中出现负数，则终止迭代
        if (v0 * v0 * t * t - x0 * x0 < 0)
        {
            break;
        }
    }

    return t;
}

int main(int argc, char *argv[])
{
    setlocale(LC_ALL, "");
    ros::init(argc, argv, "robot_detect");
    ros::NodeHandle nh;
    DetectNode detect_node(nh);

    // 开始循环，直到节点关闭
    ros::spin();
    return 0;
}

DetectNode::DetectNode(ros::NodeHandle nh) : debug_armor_it(nh)
{

    armors_pub = nh.advertise<robotinterfaces::Armors>("detect_armors", 1);
    // debug
    debug_armors_pub = debug_armor_it.advertise("armors_image", 1);
    
    image_sub = nh.subscribe("camera_image", 1, &DetectNode::imageCallback, this);

    detect_color = nh.param("detect_color", 0); // 0  for red   1 for blue

    // no need to modify
    threshold = nh.param("threshold", 0.7);
    binary_thres = nh.param("binary_thres", 160);

    armor_detector = initDetector();
    pnp_solver = std::make_unique<PnPSolver>(camera_matrix, dist_coeffs);
}

std::unique_ptr<ArmorDetector> DetectNode::initDetector()
{
    l.max_ratio = 0.4;
    l.min_ratio = 0.1;
    l.max_angle = 40;

    a.min_light_ratio = 0.7;
    a.min_small_center_distance = 0.8;
    a.max_small_center_distance = 3.2;
    a.min_large_center_distance = 3.2;
    a.max_large_center_distance = 5.5;
    a.max_angle = 35;

    ignore_classes.push_back("negative");
    model_path = ros::package::getPath("robotdetect") + "/model/mlp.onnx";
    label_path = ros::package::getPath("robotdetect") + "/model/label.txt";

    auto detector = std::make_unique<ArmorDetector>(binary_thres, detect_color, l, a);
    detector->classifier = std::make_unique<NumberClassifier>(model_path, label_path, threshold, ignore_classes);

    return detector;
}

void DetectNode::imageCallback(const sensor_msgs::ImageConstPtr &msg)
{
    try
    {
        // 将ROS图像消息转换成OpenCV图像格式
        cv::Mat image = cv_bridge::toCvShare(msg, "bgr8")->image;

        auto armors = armor_detector->work(image);
        // debug
        armor_detector->drawResults(image);
        debug_armor_image_msg = cv_bridge::CvImage(msg->header, "bgr8", image).toImageMsg();
        debug_armors_pub.publish(debug_armor_image_msg);

        robotinterfaces::Armor armor_msg;
        armors_msg.header = msg->header;
        armors_msg.armors.clear(); // 这个地方忘清零了，我真是个sb
        

        for (const auto &armor : armors)
        {
            cv::Mat rvec, tvec;
            bool success = pnp_solver->solvePnP(armor, rvec, tvec);
        
            if (success)
            {
                // Fill basic info
                armor_msg.type = ARMOR_TYPE_STR[static_cast<int>(armor.type)];
                armor_msg.number = armor.number;

                // Fill pose
                armor_msg.pose.position.x = tvec.at<double>(0);
                armor_msg.pose.position.y = tvec.at<double>(1);
                armor_msg.pose.position.z = tvec.at<double>(2);
                x0 = sqrt(tvec.at<double>(0) * tvec.at<double>(0) + tvec.at<double>(1) * tvec.at<double>(1));
                z0 = tvec.at<double>(2)/10;
                if (true)
                {
                    // 计算两个球体的雷诺数
                    // double Re_large = calculateReynoldsNumber(diameter_large);
                    // double Re_small = calculateReynoldsNumber(diameter_small);

                    // // 计算两个球体的阻力系数
                    // double Cd_large = calculateDragCoefficient(Re_large);
                    // double Cd_small = calculateDragCoefficient(Re_small);

                    // // 假设阻力系数Cd对应的lambda值
                    // double lambda_large = Cd_large / (2 * rho * diameter_large);
                    // double lambda_small = Cd_small / (2 * rho * diameter_small);

                    // // 初始猜测角度为45度
                     double numerator = z0 + g * z0 * z0 / (v0 * v0);
                    double denominator = std::sqrt(x0 * x0 + z0 * z0);
                    double alpa = asin(numerator / denominator);
                    double fai=atan(z0/x0);
                    // double initial_guess = 0.2;
                    // 调用牛顿迭代法函数求解最佳发射角度
                    // double large_angle = newtonRaphson(initial_guess, lambda_large, -1);
                    // // if (v0 * v0 * large_angle * large_angle - x0 * x0 >= 0 and x0 / v0 < initial_guess < 1 / lambda_large)
                    // // {
                    // double theta = std::acos(x0 / (v0 * large_angle));
                    // 确保角度是负的
                    //     if (theta < 0)
                    //     {
                    //         largeA.push_back(theta);
                    //     }
                    // }
                    //     double small_angle = newtonRaphson(initial_guess, lambda_small, -1);
                    //     if (v0 * v0 * small_angle * small_angle - x0 * x0 >= 0 and x0 / v0 < initial_guess < 1 / lambda_large)
                    //     {
                    //         double theta = std::acos(x0 / (v0 * small_angle));
                    //         // 确保角度是负的
                    //         if (theta < 0)
                    //         {
                    //             smallA.push_back(theta);
                    //         }
                    //     }
                    //     large_angle = newtonRaphson(initial_guess, lambda_large, 1);
                    //     if (v0 * v0 * large_angle * large_angle - x0 * x0 >= 0 and x0 / v0 < initial_guess < 1 / lambda_large)
                    //     {
                    //         double theta = std::acos(x0 / (v0 * large_angle));
                    //         // 确保角度是正的
                    //         if (0 < theta < 40)
                    //         {
                    //             largeA.push_back(theta);
                    //         }
                    //     }
                    //     small_angle = newtonRaphson(initial_guess, lambda_large, 1);
                    //     if (v0 * v0 * small_angle * small_angle - x0 * x0 >= 0 and x0 / v0 < initial_guess < 1 / lambda_large)
                    //     {
                    //         double theta = std::acos(x0 / (v0 * small_angle));
                    //         // 确保角度是正的
                    //         if (0 < theta < 35)
                    //         {
                    //             smallA.push_back(theta);
                    //         }
                    //     }
                    //     if (findValue(largeA) != -1)
                    //     {
                    //         std::cout << findValue(largeA);
                    //     }
                    //     ROS_INFO_STREAM(findValue(largeA));
                    //     findValue(smallA);
                    //     if (findValue(smallA) != -1)
                    //     {
                    //         std::cout << findValue(smallA);
                    //     }
                    //     ROS_INFO_STREAM(findValue(smallA));
                    // }
                    double theta=(alpa+fai)/2;
                    ROS_INFO("theta: %f", theta);}
                    ROS_INFO_STREAM(x0);
                    ROS_INFO_STREAM(tvec.at<double>(0));
                    ROS_INFO_STREAM(tvec.at<double>(1));


                    ROS_INFO_STREAM(z0);


                    

                    // rvec to 3x3 rotation matrix
                    cv::Mat rotation_matrix;
                    cv::Rodrigues(rvec, rotation_matrix);
                    // // rotation matrix to quaternion
                    tf2::Matrix3x3 tf2_rotation_matrix(
                        rotation_matrix.at<double>(0, 0), rotation_matrix.at<double>(0, 1),
                        rotation_matrix.at<double>(0, 2), rotation_matrix.at<double>(1, 0),
                        rotation_matrix.at<double>(1, 1), rotation_matrix.at<double>(1, 2),
                        rotation_matrix.at<double>(2, 0), rotation_matrix.at<double>(2, 1),
                        rotation_matrix.at<double>(2, 2));
                    tf2::Quaternion tf2_q;
                    tf2_rotation_matrix.getRotation(tf2_q);
                    armor_msg.pose.orientation = tf2::toMsg(tf2_q);

                    // Fill the distance to image center
                    armor_msg.distance_to_image_center = pnp_solver->calculateDistanceToCenter(armor.center);

                    armors_msg.armors.emplace_back(armor_msg);
                }
                else
                {
                    ROS_WARN("PnP failed");
                }
            }

            armors_pub.publish(armors_msg);
        }
        catch (cv_bridge::Exception &e)
        {
            ROS_ERROR("Could not convert from '%s' to 'bgr8'.", msg->encoding.c_str());
        }
    }
