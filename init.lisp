;; -*-lisp-*-
;;
;; StumpWM configuration file

(in-package :stumpwm)

;; General configuration
(setf *message-window-gravity* :center
      *window-border-style* :thin)

;; Enable mode-line on all screens
(dolist (head (screen-heads (current-screen)))
  (enable-mode-line (current-screen) head t))

;; Optionally, load personal settings
(let ((personal-file-path (merge-pathnames "personal.lisp" *data-dir*)))
  (when (probe-file personal-file-path)
    (load personal-file-path)))
