; Auto-generated. Do not edit!


(cl:in-package robotinterfaces-msg)


;//! \htmlinclude Armors.msg.html

(cl:defclass <Armors> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (armors
    :reader armors
    :initarg :armors
    :type (cl:vector robotinterfaces-msg:Armor)
   :initform (cl:make-array 0 :element-type 'robotinterfaces-msg:Armor :initial-element (cl:make-instance 'robotinterfaces-msg:Armor))))
)

(cl:defclass Armors (<Armors>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Armors>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Armors)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name robotinterfaces-msg:<Armors> is deprecated: use robotinterfaces-msg:Armors instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <Armors>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader robotinterfaces-msg:header-val is deprecated.  Use robotinterfaces-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'armors-val :lambda-list '(m))
(cl:defmethod armors-val ((m <Armors>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader robotinterfaces-msg:armors-val is deprecated.  Use robotinterfaces-msg:armors instead.")
  (armors m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Armors>) ostream)
  "Serializes a message object of type '<Armors>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'armors))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'armors))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Armors>) istream)
  "Deserializes a message object of type '<Armors>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'armors) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'armors)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'robotinterfaces-msg:Armor))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Armors>)))
  "Returns string type for a message object of type '<Armors>"
  "robotinterfaces/Armors")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Armors)))
  "Returns string type for a message object of type 'Armors"
  "robotinterfaces/Armors")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Armors>)))
  "Returns md5sum for a message object of type '<Armors>"
  "69c17fbb4896cb79d8e99efc826b5907")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Armors)))
  "Returns md5sum for a message object of type 'Armors"
  "69c17fbb4896cb79d8e99efc826b5907")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Armors>)))
  "Returns full string definition for message of type '<Armors>"
  (cl:format cl:nil "std_msgs/Header header~%Armor[] armors~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: robotinterfaces/Armor~%string number~%string type~%float32 distance_to_image_center~%geometry_msgs/Pose pose~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Armors)))
  "Returns full string definition for message of type 'Armors"
  (cl:format cl:nil "std_msgs/Header header~%Armor[] armors~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: robotinterfaces/Armor~%string number~%string type~%float32 distance_to_image_center~%geometry_msgs/Pose pose~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Armors>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'armors) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Armors>))
  "Converts a ROS message object to a list"
  (cl:list 'Armors
    (cl:cons ':header (header msg))
    (cl:cons ':armors (armors msg))
))
