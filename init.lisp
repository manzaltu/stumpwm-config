;; -*-lisp-*-
;;
;; StumpWM configuration file

(in-package :stumpwm)

;; General configuration
(setf *message-window-gravity* :center
      *window-border-style* :thin)

;; Optionally, load personal settings
(let ((personal-file-path (merge-pathnames "personal.lisp" *data-dir*)))
  (when (probe-file personal-file-path)
    (load personal-file-path)))
