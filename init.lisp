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

(setf *window-format* "%m%n%s%50c")

(defvar *my-cache-dir-path* (merge-pathnames ".cache/" *data-dir*)
  "Config cache directory path")

(defun my-cache-path (filename)
  "Return a valid file path for FILENAME under the cache directory."
  (merge-pathnames *my-cache-dir-path* filename))

;; Keybindings
(set-prefix-key (kbd "s-Insert"))

(defvar *group-key-map* (make-sparse-keymap))
(define-key *group-key-map* (kbd "s-w") "vgroups")
(define-key *group-key-map* (kbd "s-g") "gnew")
(define-key *group-key-map* (kbd "s-o") "gother")
(define-key *group-key-map* (kbd "s-s") "gselect")
(define-key *group-key-map* (kbd "s-m") "gmove")
(define-key *group-key-map* (kbd "s-M") "gmove-marked")
(define-key *group-key-map* (kbd "s-c") "gkill")
(define-key *group-key-map* (kbd "s-r") "grename")

(define-key *top-map* (kbd "s-SPC") "emacs")
(define-key *top-map* (kbd "s-ESC") "exec killall -USR2 emacs")
(define-key *top-map* (kbd "s-t") "exec kitty")
(define-key *top-map* (kbd "s-b") "banish")
(define-key *top-map* (kbd "s-x") "exec")
(define-key *top-map* (kbd "s-C-g") "abort")
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
(define-key *top-map* (kbd "s-j") "next-in-frame")
(define-key *top-map* (kbd "s-k") "prev-in-frame")
(define-key *top-map* (kbd "s-C-j") "gnext")
(define-key *top-map* (kbd "s-C-k") "gprev")
(define-key *top-map* (kbd "s-C-J") "gnext-with-window")
(define-key *top-map* (kbd "s-C-K") "gprev-with-window")
(define-key *top-map* (kbd "s-DEL") "other-window")
(define-key *top-map* (kbd "s-g") *group-key-map*)
(define-key *top-map* (kbd "s-1") "gselect 1")
(define-key *top-map* (kbd "s-2") "gselect 2")
(define-key *top-map* (kbd "s-3") "gselect 3")
(define-key *top-map* (kbd "s-4") "gselect 4")
(define-key *top-map* (kbd "s-5") "gselect 5")
(define-key *top-map* (kbd "s-6") "gselect 6")
(define-key *top-map* (kbd "s-7") "gselect 7")
(define-key *top-map* (kbd "s-8") "gselect 8")
(define-key *top-map* (kbd "s-9") "gselect 9")
(define-key *top-map* (kbd "s-c") "remove")
(define-key *top-map* (kbd "s-v") "hsplit")
(define-key *top-map* (kbd "s-V") "vsplit")
(define-key *top-map* (kbd "s-r") "iresize")
(define-key *top-map* (kbd "s-R") "redisplay")
(define-key *top-map* (kbd "s-C-r") "refresh-heads")
(define-key *top-map* (kbd "s-o") "fother")
(define-key *top-map* (kbd "s-F") "fselect")
(define-key *top-map* (kbd "s--") "fclear")
(define-key *top-map* (kbd "s-C") "only")
(define-key *top-map* (kbd "s-q") "quit-confirm")
(define-key *top-map* (kbd "s-Q") "restart-hard")
(define-key *top-map* (kbd "s-+") "balance-frames")
(define-key *top-map* (kbd "s-u") "next-urgent")
(define-key *top-map* (kbd "s-RET") "expose")
(define-key *top-map* (kbd "s-Delete") "delete")
(define-key *top-map* (kbd "s-C-Delete") "kill")
(define-key *top-map* (kbd "s-w") "windowlist")
(define-key *top-map* (kbd "s-W") "repack-window-numbers")
(define-key *top-map* (kbd "s-n") "number")
(define-key *top-map* (kbd "s-z") "fullscreen")
(define-key *top-map* (kbd "s-i") "info")
(define-key *top-map* (kbd "s-p") "float-this")
(define-key *top-map* (kbd "s-P") "unfloat-this")
(define-key *top-map* (kbd "s-l") "exec xsecurelock")
(define-key *top-map* (kbd "s-F1") "exec pactl set-sink-volume @DEFAULT_SINK@ -5%")
(define-key *top-map* (kbd "s-F2") "exec pactl set-sink-volume @DEFAULT_SINK@ +5%")
(define-key *top-map* (kbd "s-F3") "exec pactl set-sink-mute @DEFAULT_SINK@ toggle")
(define-key *top-map* (kbd "Print") "exec flameshot gui")

;; Frame split helpers
(defun my-vsplit-three (&key (ratio .3) (group (current-group)) (dir :column))
  "Split frame into 3 using the provided RATIO."
  (let* ((split-1 (- 1 ratio))
         (split-2 (* ratio (/ 1 split-1))))
    (only)
    (stumpwm::split-frame-in-dir group dir split-1)
    (stumpwm::split-frame-in-dir group dir split-2)
    ratio))

(defcommand (my-vsplit-3 stumpwm::tile-group) (&optional (ratio ".25"))
    (:string)
  (my-vsplit-three :ratio (read-from-string ratio)))

(define-key *top-map* (kbd "s-a") "my-vsplit-3")

;; Keyboard layout
(defcommand toggle-kb-layout-us-il () ()
  "Toggle between a us and il keyboard layouts."
  (let ((us-layout (cl-ppcre:scan "layout:\\s*us"
                                  (run-shell-command "setxkbmap -query" t))))
    (if us-layout
        (run-shell-command "setxkbmap il")
        (run-shell-command "setxkbmap us"))))

(define-key *top-map* (kbd "s-TAB") "toggle-kb-layout-us-il")

;; End session
(load-module "end-session")
(define-key *top-map* (kbd "s-F12") "end-session")

;; Top keymap help
(defcommand help-topmap () ()
  "Display bindings for the top keymap."
  (stumpwm::display-bindings-for-keymaps nil stumpwm::*top-map*))

(define-key *help-map* (kbd "s-h") "help-topmap")

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

(setf *screen-mode-line-format* "%g | %W ^> %C %M %l %B ^B%d^b")

;; Load window placement rules
(let ((window-rules-file-path (my-cache-path "window-rules.lisp")))
  (when (probe-file window-rules-file-path)
    (restore-window-placement-rules window-rules-file-path)))

;; Do not open new windows over Emacs
(defun my-new-window-preferred-frame (windows)
  "Return new window frame preferences."
  (let* ((current-window (stumpwm:current-window))
         (window-class (when current-window (stumpwm:window-class current-window))))
    (if (string= window-class "Emacs")
        '(:empty :unfocused)
        '(:focued))))

(setf *new-window-preferred-frame* #'my-new-window-preferred-frame)

;; Optionally, load personal settings
(let ((personal-file-path (merge-pathnames "personal.lisp" *data-dir*)))
  (when (probe-file personal-file-path)
    (load personal-file-path)))

;; If on widescreen, split the screen to 3 and select the frame in the center
(let ((wide-screen-p
        (>= (/ (stumpwm:screen-width (stumpwm:current-screen))
               (stumpwm:screen-height (stumpwm:current-screen)))
            32/9)))
  (when wide-screen-p
    (my-vsplit-3)
    (move-focus :right)))

;; Start Emacs
(emacs)
