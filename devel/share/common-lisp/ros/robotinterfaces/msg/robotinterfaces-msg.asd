
(cl:in-package :asdf)

(defsystem "robotinterfaces-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :geometry_msgs-msg
               :std_msgs-msg
)
  :components ((:file "_package")
    (:file "Armor" :depends-on ("_package_Armor"))
    (:file "_package_Armor" :depends-on ("_package"))
    (:file "Armors" :depends-on ("_package_Armors"))
    (:file "_package_Armors" :depends-on ("_package"))
    (:file "Target" :depends-on ("_package_Target"))
    (:file "_package_Target" :depends-on ("_package"))
  ))