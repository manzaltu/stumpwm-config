;; -*-lisp-*-
;;
;; StumpWM configuration file

;; Init slynk for Emacs integration
(ql:quickload :slynk)
(ignore-errors (slynk:create-server :dont-close t))

(in-package :stumpwm)

;; Add stumpish to PATH
(let ((stumpish-folder-path
        (namestring (merge-pathnames "modules/util/stumpish" *data-dir*))))
  (setf (getenv "PATH") (concatenate
                         'string
                         (getenv "PATH") ":" stumpish-folder-path)))

;; General configuration
(setf *message-window-gravity* :center
      *input-window-gravity* :center
      *window-border-style* :thin
      *mouse-focus-policy* :click
      *suppress-frame-indicator* t)

(set-prefix-key (kbd "Menu"))

(define-key *top-map* (kbd "s-SPC") "emacs")
(define-key *top-map* (kbd "s-ESC") "exec killall -USR2 emacs")
(define-key *top-map* (kbd "s-t") "exec kitty")
(define-key *top-map* (kbd "s-b") "banish")
(define-key *top-map* (kbd "s-x") "exec")
(define-key *top-map* (kbd "s-g") "abort")
(define-key *top-map* (kbd "s-;") "colon")
(define-key *top-map* (kbd "s-:") "eval")
(define-key *top-map* (kbd "s-m") "lastmsg")
(define-key *top-map* (kbd "s-h") *help-map*)
(define-key *top-map* (kbd "s-e") "move-focus up")
(define-key *top-map* (kbd "s-d") "move-focus down")
(define-key *top-map* (kbd "s-s") "move-focus left")
(define-key *top-map* (kbd "s-f") "move-focus right")
(define-key *top-map* (kbd "s-C-e") "move-window up")
(define-key *top-map* (kbd "s-C-d") "move-window down")
(define-key *top-map* (kbd "s-C-s") "move-window left")
(define-key *top-map* (kbd "s-C-f") "move-window right")
(define-key *top-map* (kbd "s-C-E") "exchange-direction up")
(define-key *top-map* (kbd "s-C-D") "exchange-direction down")
(define-key *top-map* (kbd "s-C-S") "exchange-direction left")
(define-key *top-map* (kbd "s-C-F") "exchange-direction right")
(define-key *top-map* (kbd "s-n") "next-in-frame")
(define-key *top-map* (kbd "s-p") "prev-in-frame")
(define-key *top-map* (kbd "s-C-n") "pull-hidden-next")
(define-key *top-map* (kbd "s-C-p") "pull-hidden-previous")
(define-key *top-map* (kbd "s-TAB") "pull-hidden-other")
(define-key *top-map* (kbd "s-c") "remove")
(define-key *top-map* (kbd "s-v") "hsplit")
(define-key *top-map* (kbd "s-V") "vsplit")
(define-key *top-map* (kbd "s-r") "iresize")
(define-key *top-map* (kbd "s-R") "redisplay")
(define-key *top-map* (kbd "s-o") "fother")
(define-key *top-map* (kbd "s-F") "fselect")
(define-key *top-map* (kbd "s--") "fclear")
(define-key *top-map* (kbd "s-z") "only")
(define-key *top-map* (kbd "s-q") "quit-confirm")
(define-key *top-map* (kbd "s-Q") "restart-hard")
(define-key *top-map* (kbd "s-+") "balance-frames")
(define-key *top-map* (kbd "s-u") "next-urgent")
(define-key *top-map* (kbd "s-RET") "expose")
(define-key *top-map* (kbd "s-k") "delete")
(define-key *top-map* (kbd "s-K") "kill")
(define-key *top-map* (kbd "s-w") "windowlist")
(define-key *top-map* (kbd "s-N") "number")
(define-key *top-map* (kbd "s-F11") "fullscreen")
(define-key *top-map* (kbd "s-i") "info")
(define-key *top-map* (kbd "s-j") "float-this")
(define-key *top-map* (kbd "s-J") "unfloat-this")
(define-key *top-map* (kbd "s-F1") "exec pactl set-sink-volume @DEFAULT_SINK@ -5%")
(define-key *top-map* (kbd "s-F2") "exec pactl set-sink-volume @DEFAULT_SINK@ +5%")
(define-key *top-map* (kbd "s-F3") "exec pactl set-sink-mute @DEFAULT_SINK@ toggle")
(define-key *top-map* (kbd "Print") "exec flameshot gui")

;; Keyboard layout
(defcommand toggle-kb-layout-us-il () ()
  "Toggle between a us and il keyboard layouts."
  (let ((us-layout (cl-ppcre:scan "layout:\\s*us"
                                  (run-shell-command "setxkbmap -query" t))))
    (if us-layout
        (run-shell-command "setxkbmap il")
        (run-shell-command "setxkbmap us"))))

(define-key *top-map* (kbd "s-DEL") "toggle-kb-layout-us-il")

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

(setf *time-modeline-string* "%a %b %e %Y %k:%M")

(setf *screen-mode-line-format* "[^B%n^b] %W ^> %C %M %l %B ^B%d^b")

;; Optionally, load personal settings
(let ((personal-file-path (merge-pathnames "personal.lisp" *data-dir*)))
  (when (probe-file personal-file-path)
    (load personal-file-path)))

;; Start Emacs
(emacs)
