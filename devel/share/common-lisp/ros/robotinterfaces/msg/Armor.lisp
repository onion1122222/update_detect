; Auto-generated. Do not edit!


(cl:in-package robotinterfaces-msg)


;//! \htmlinclude Armor.msg.html

(cl:defclass <Armor> (roslisp-msg-protocol:ros-message)
  ((number
    :reader number
    :initarg :number
    :type cl:string
    :initform "")
   (type
    :reader type
    :initarg :type
    :type cl:string
    :initform "")
   (distance_to_image_center
    :reader distance_to_image_center
    :initarg :distance_to_image_center
    :type cl:float
    :initform 0.0)
   (pose
    :reader pose
    :initarg :pose
    :type geometry_msgs-msg:Pose
    :initform (cl:make-instance 'geometry_msgs-msg:Pose)))
)

(cl:defclass Armor (<Armor>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Armor>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Armor)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name robotinterfaces-msg:<Armor> is deprecated: use robotinterfaces-msg:Armor instead.")))

(cl:ensure-generic-function 'number-val :lambda-list '(m))
(cl:defmethod number-val ((m <Armor>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader robotinterfaces-msg:number-val is deprecated.  Use robotinterfaces-msg:number instead.")
  (number m))

(cl:ensure-generic-function 'type-val :lambda-list '(m))
(cl:defmethod type-val ((m <Armor>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader robotinterfaces-msg:type-val is deprecated.  Use robotinterfaces-msg:type instead.")
  (type m))

(cl:ensure-generic-function 'distance_to_image_center-val :lambda-list '(m))
(cl:defmethod distance_to_image_center-val ((m <Armor>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader robotinterfaces-msg:distance_to_image_center-val is deprecated.  Use robotinterfaces-msg:distance_to_image_center instead.")
  (distance_to_image_center m))

(cl:ensure-generic-function 'pose-val :lambda-list '(m))
(cl:defmethod pose-val ((m <Armor>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader robotinterfaces-msg:pose-val is deprecated.  Use robotinterfaces-msg:pose instead.")
  (pose m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Armor>) ostream)
  "Serializes a message object of type '<Armor>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'number))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'number))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'type))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'type))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'distance_to_image_center))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'pose) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Armor>) istream)
  "Deserializes a message object of type '<Armor>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'number) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'number) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'type) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'type) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'distance_to_image_center) (roslisp-utils:decode-single-float-bits bits)))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'pose) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Armor>)))
  "Returns string type for a message object of type '<Armor>"
  "robotinterfaces/Armor")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Armor)))
  "Returns string type for a message object of type 'Armor"
  "robotinterfaces/Armor")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Armor>)))
  "Returns md5sum for a message object of type '<Armor>"
  "b1510e3aae8707ed5d8323805f976d4c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Armor)))
  "Returns md5sum for a message object of type 'Armor"
  "b1510e3aae8707ed5d8323805f976d4c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Armor>)))
  "Returns full string definition for message of type '<Armor>"
  (cl:format cl:nil "string number~%string type~%float32 distance_to_image_center~%geometry_msgs/Pose pose~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Armor)))
  "Returns full string definition for message of type 'Armor"
  (cl:format cl:nil "string number~%string type~%float32 distance_to_image_center~%geometry_msgs/Pose pose~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Armor>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'number))
     4 (cl:length (cl:slot-value msg 'type))
     4
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'pose))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Armor>))
  "Converts a ROS message object to a list"
  (cl:list 'Armor
    (cl:cons ':number (number msg))
    (cl:cons ':type (type msg))
    (cl:cons ':distance_to_image_center (distance_to_image_center msg))
    (cl:cons ':pose (pose msg))
))
