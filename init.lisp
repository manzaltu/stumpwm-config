;; -*-lisp-*-
;;
;; StumpWM configuration file

(in-package :stumpwm)

;; General configuration
(setf *message-window-gravity* :center
      *input-window-gravity* :center
      *window-border-style* :thin)

(set-prefix-key (kbd "Menu"))

(define-key *root-map* (kbd "e") "move-focus up")
(define-key *root-map* (kbd "d") "move-focus down")
(define-key *root-map* (kbd "s") "move-focus left")
(define-key *root-map* (kbd "f") "move-focus right")
(define-key *root-map* (kbd "C-e") "move-window up")
(define-key *root-map* (kbd "C-d") "move-window down")
(define-key *root-map* (kbd "C-s") "move-window left")
(define-key *root-map* (kbd "C-f") "move-window right")
(define-key *root-map* (kbd "SPC") "emacs")
(define-key *root-map* (kbd "RET") "exec")
(define-key *root-map* (kbd "DEL") "expose")
(define-key *root-map* (kbd "v") "hsplit")
(define-key *root-map* (kbd "V") "vsplit")
(define-key *root-map* (kbd "g") "fselect")

;; Mode-line configuration
(setf *mode-line-timeout* 2)

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

(setf *time-modeline-string* "%a %b %e %Y %k:%M")

(setf *screen-mode-line-format* "[^B%n^b] %W ^> %C | %M | %l | %I | %h | %B | ^B%d^b")

;; Optionally, load personal settings
(let ((personal-file-path (merge-pathnames "personal.lisp" *data-dir*)))
  (when (probe-file personal-file-path)
    (load personal-file-path)))
