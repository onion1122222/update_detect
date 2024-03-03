;; Auto-generated. Do not edit!


(when (boundp 'robotinterfaces::Armor)
  (if (not (find-package "ROBOTINTERFACES"))
    (make-package "ROBOTINTERFACES"))
  (shadow 'Armor (find-package "ROBOTINTERFACES")))
(unless (find-package "ROBOTINTERFACES::ARMOR")
  (make-package "ROBOTINTERFACES::ARMOR"))

(in-package "ROS")
;;//! \htmlinclude Armor.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass robotinterfaces::Armor
  :super ros::object
  :slots (_number _type _distance_to_image_center _pose ))

(defmethod robotinterfaces::Armor
  (:init
   (&key
    ((:number __number) "")
    ((:type __type) "")
    ((:distance_to_image_center __distance_to_image_center) 0.0)
    ((:pose __pose) (instance geometry_msgs::Pose :init))
    )
   (send-super :init)
   (setq _number (string __number))
   (setq _type (string __type))
   (setq _distance_to_image_center (float __distance_to_image_center))
   (setq _pose __pose)
   self)
  (:number
   (&optional __number)
   (if __number (setq _number __number)) _number)
  (:type
   (&optional __type)
   (if __type (setq _type __type)) _type)
  (:distance_to_image_center
   (&optional __distance_to_image_center)
   (if __distance_to_image_center (setq _distance_to_image_center __distance_to_image_center)) _distance_to_image_center)
  (:pose
   (&rest __pose)
   (if (keywordp (car __pose))
       (send* _pose __pose)
     (progn
       (if __pose (setq _pose (car __pose)))
       _pose)))
  (:serialization-length
   ()
   (+
    ;; string _number
    4 (length _number)
    ;; string _type
    4 (length _type)
    ;; float32 _distance_to_image_center
    4
    ;; geometry_msgs/Pose _pose
    (send _pose :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _number
       (write-long (length _number) s) (princ _number s)
     ;; string _type
       (write-long (length _type) s) (princ _type s)
     ;; float32 _distance_to_image_center
       (sys::poke _distance_to_image_center (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; geometry_msgs/Pose _pose
       (send _pose :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _number
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _number (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _type
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _type (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; float32 _distance_to_image_center
     (setq _distance_to_image_center (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; geometry_msgs/Pose _pose
     (send _pose :deserialize buf ptr-) (incf ptr- (send _pose :serialization-length))
   ;;
   self)
  )

(setf (get robotinterfaces::Armor :md5sum-) "b1510e3aae8707ed5d8323805f976d4c")
(setf (get robotinterfaces::Armor :datatype-) "robotinterfaces/Armor")
(setf (get robotinterfaces::Armor :definition-)
      "string number
string type
float32 distance_to_image_center
geometry_msgs/Pose pose
================================================================================
MSG: geometry_msgs/Pose
# A representation of pose in free space, composed of position and orientation. 
Point position
Quaternion orientation

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w

")



(provide :robotinterfaces/Armor "b1510e3aae8707ed5d8323805f976d4c")


