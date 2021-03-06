(in-package :cl-user)
(defpackage lucerne-auth
  (:use :cl)
  (:import-from :clack.request
                :env)
  (:export :<auth-manager>
           :get-userid
           :login
           :logout
           :logged-in-p))
(in-package :lucerne-auth)

(defclass <auth-manager> ()
  ((get-user :initarg :get-user
             :reader  get-user
             :type    function)
   (user-pass :initarg :user-pass
              :reader   user-pass
              :type     function)))

(defun get-userid (req)
  (gethash :userid (lucerne:session req)))

(defun login (req userid)
  (setf (gethash :userid (lucerne:session req))
        userid))

(defun logout (req)
  (remhash :userid (get-session req)))

(defun logged-in-p (req)
  (if (get-userid req) t))
