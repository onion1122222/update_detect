;; Auto-generated. Do not edit!


(when (boundp 'robotinterfaces::Target)
  (if (not (find-package "ROBOTINTERFACES"))
    (make-package "ROBOTINTERFACES"))
  (shadow 'Target (find-package "ROBOTINTERFACES")))
(unless (find-package "ROBOTINTERFACES::TARGET")
  (make-package "ROBOTINTERFACES::TARGET"))

(in-package "ROS")
;;//! \htmlinclude Target.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass robotinterfaces::Target
  :super ros::object
  :slots (_header _tracking _id _armors_num _position _velocity _yaw _v_yaw _radius_1 _radius_2 _dz ))

(defmethod robotinterfaces::Target
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:tracking __tracking) nil)
    ((:id __id) "")
    ((:armors_num __armors_num) 0)
    ((:position __position) (instance geometry_msgs::Point :init))
    ((:velocity __velocity) (instance geometry_msgs::Vector3 :init))
    ((:yaw __yaw) 0.0)
    ((:v_yaw __v_yaw) 0.0)
    ((:radius_1 __radius_1) 0.0)
    ((:radius_2 __radius_2) 0.0)
    ((:dz __dz) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _tracking __tracking)
   (setq _id (string __id))
   (setq _armors_num (round __armors_num))
   (setq _position __position)
   (setq _velocity __velocity)
   (setq _yaw (float __yaw))
   (setq _v_yaw (float __v_yaw))
   (setq _radius_1 (float __radius_1))
   (setq _radius_2 (float __radius_2))
   (setq _dz (float __dz))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:tracking
   (&optional (__tracking :null))
   (if (not (eq __tracking :null)) (setq _tracking __tracking)) _tracking)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:armors_num
   (&optional __armors_num)
   (if __armors_num (setq _armors_num __armors_num)) _armors_num)
  (:position
   (&rest __position)
   (if (keywordp (car __position))
       (send* _position __position)
     (progn
       (if __position (setq _position (car __position)))
       _position)))
  (:velocity
   (&rest __velocity)
   (if (keywordp (car __velocity))
       (send* _velocity __velocity)
     (progn
       (if __velocity (setq _velocity (car __velocity)))
       _velocity)))
  (:yaw
   (&optional __yaw)
   (if __yaw (setq _yaw __yaw)) _yaw)
  (:v_yaw
   (&optional __v_yaw)
   (if __v_yaw (setq _v_yaw __v_yaw)) _v_yaw)
  (:radius_1
   (&optional __radius_1)
   (if __radius_1 (setq _radius_1 __radius_1)) _radius_1)
  (:radius_2
   (&optional __radius_2)
   (if __radius_2 (setq _radius_2 __radius_2)) _radius_2)
  (:dz
   (&optional __dz)
   (if __dz (setq _dz __dz)) _dz)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; bool _tracking
    1
    ;; string _id
    4 (length _id)
    ;; int32 _armors_num
    4
    ;; geometry_msgs/Point _position
    (send _position :serialization-length)
    ;; geometry_msgs/Vector3 _velocity
    (send _velocity :serialization-length)
    ;; float64 _yaw
    8
    ;; float64 _v_yaw
    8
    ;; float64 _radius_1
    8
    ;; float64 _radius_2
    8
    ;; float64 _dz
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; bool _tracking
       (if _tracking (write-byte -1 s) (write-byte 0 s))
     ;; string _id
       (write-long (length _id) s) (princ _id s)
     ;; int32 _armors_num
       (write-long _armors_num s)
     ;; geometry_msgs/Point _position
       (send _position :serialize s)
     ;; geometry_msgs/Vector3 _velocity
       (send _velocity :serialize s)
     ;; float64 _yaw
       (sys::poke _yaw (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _v_yaw
       (sys::poke _v_yaw (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _radius_1
       (sys::poke _radius_1 (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _radius_2
       (sys::poke _radius_2 (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _dz
       (sys::poke _dz (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; bool _tracking
     (setq _tracking (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; string _id
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _id (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; int32 _armors_num
     (setq _armors_num (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; geometry_msgs/Point _position
     (send _position :deserialize buf ptr-) (incf ptr- (send _position :serialization-length))
   ;; geometry_msgs/Vector3 _velocity
     (send _velocity :deserialize buf ptr-) (incf ptr- (send _velocity :serialization-length))
   ;; float64 _yaw
     (setq _yaw (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _v_yaw
     (setq _v_yaw (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _radius_1
     (setq _radius_1 (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _radius_2
     (setq _radius_2 (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _dz
     (setq _dz (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get robotinterfaces::Target :md5sum-) "d3d57638e797af5f20ce935911cd4136")
(setf (get robotinterfaces::Target :datatype-) "robotinterfaces/Target")
(setf (get robotinterfaces::Target :definition-)
      "std_msgs/Header header
bool tracking
string id
int32 armors_num
geometry_msgs/Point position
geometry_msgs/Vector3 velocity
float64 yaw
float64 v_yaw
float64 radius_1
float64 radius_2
float64 dz
================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Vector3
# This represents a vector in free space. 
# It is only meant to represent a direction. Therefore, it does not
# make sense to apply a translation to it (e.g., when applying a 
# generic rigid transformation to a Vector3, tf2 will only apply the
# rotation). If you want your data to be translatable too, use the
# geometry_msgs/Point message instead.

float64 x
float64 y
float64 z
")



(provide :robotinterfaces/Target "d3d57638e797af5f20ce935911cd4136")


