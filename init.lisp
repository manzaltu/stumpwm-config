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

;; Add mode-line modules
(load-module "cpu")
(load-module "battery-portable")
(load-module "mem")
(load-module "net")
(load-module "wifi")
(load-module "hostname")

(setf *screen-mode-line-format* "[^B%n^b] %W ^> %C %M %l %I %h %B")

;; Optionally, load personal settings
(let ((personal-file-path (merge-pathnames "personal.lisp" *data-dir*)))
  (when (probe-file personal-file-path)
    (load personal-file-path)))
