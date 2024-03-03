;; Auto-generated. Do not edit!


(when (boundp 'robotinterfaces::Armors)
  (if (not (find-package "ROBOTINTERFACES"))
    (make-package "ROBOTINTERFACES"))
  (shadow 'Armors (find-package "ROBOTINTERFACES")))
(unless (find-package "ROBOTINTERFACES::ARMORS")
  (make-package "ROBOTINTERFACES::ARMORS"))

(in-package "ROS")
;;//! \htmlinclude Armors.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass robotinterfaces::Armors
  :super ros::object
  :slots (_header _armors ))

(defmethod robotinterfaces::Armors
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:armors __armors) ())
    )
   (send-super :init)
   (setq _header __header)
   (setq _armors __armors)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:armors
   (&rest __armors)
   (if (keywordp (car __armors))
       (send* _armors __armors)
     (progn
       (if __armors (setq _armors (car __armors)))
       _armors)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; robotinterfaces/Armor[] _armors
    (apply #'+ (send-all _armors :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; robotinterfaces/Armor[] _armors
     (write-long (length _armors) s)
     (dolist (elem _armors)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; robotinterfaces/Armor[] _armors
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _armors (let (r) (dotimes (i n) (push (instance robotinterfaces::Armor :init) r)) r))
     (dolist (elem- _armors)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get robotinterfaces::Armors :md5sum-) "69c17fbb4896cb79d8e99efc826b5907")
(setf (get robotinterfaces::Armors :datatype-) "robotinterfaces/Armors")
(setf (get robotinterfaces::Armors :definition-)
      "std_msgs/Header header
Armor[] armors
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
MSG: robotinterfaces/Armor
string number
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



(provide :robotinterfaces/Armors "69c17fbb4896cb79d8e99efc826b5907")


