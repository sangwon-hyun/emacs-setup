;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;Miscellaneous ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq byte-compile-warnings '(cl-functions)) ;; cl is deprecated



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                    ;;;;;;;;;;;;
;; All about packages ;;;;;;;;;;;;
;;                    ;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Packages in emacs
(require 'package)
(setq package-archives
      '(("melpa-stable" . "https://stable.melpa.org/packages/")
	("melpa"        . "https://melpa.org/packages/")
	("gnu"          . "https://elpa.gnu.org/packages/")
	("org"          . "http://orgmode.org/elpa/")
	))

;; initialize built-in package management (not used now)
;; (package-initialize)

;; update packages list if we are on a new install
(unless package-archive-contents
  (package-refresh-contents))

;; ;; Auto-update packages (not used)
;; (use-package auto-package-update
;;   :config
;;   (setq auto-package-update-delete-old-versions t)
;;   (setq auto-package-update-hide-results t)
;;   (auto-package-update-maybe))

;; Always ensure that packages are installed automatically
(require 'use-package-ensure)
(setq use-package-always-ensure t)

; list the packages you want
(setq package-list '(ace-window
		     company
		     dash-functional
		     dired-toggle-sudo
		     ess
		     evil
		     evil-easymotion
		     hideshow-org
		     julia-mode
		     mixed-pitch
		     org-download
		     org-ref
		     org-super-agenda
		     persistent-scratch
		     poporg
		     smart-mode-line
		     smooth-scroll
		     smooth-scrolling
		     use-package
		     ws-butler
		     zpresent
		     magit
		     poly-R
		     imenu
		     imenu-anywhere
		     ))

;; USE-PACKAGE
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))


;; programmatically install/ensure installed
;; pkgs in your personal list
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))


;;;;;;;;;;;;;;;;;;;;;;;;;
;; Setting some paths ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;

;; Manually setting some variables to use. These are the same variables I'll use
;; throughout.
(setenv "DB" "~/Dropbox")
(setenv "ORG" "~/Dropbox/Documents/orglife")


;; Copy path and environment variables from shell environment.
;; (exec-path-from-shell-copy-env "DB") ;; These didn't work
;; (exec-path-from-shell-copy-env "ORG") ;; These didn't work
;; (when (memq window-system '(mac ns x))
;;   (exec-path-from-shell-initialize))

;; (let ((path (shell-command-to-string ". ~/.bashrc; echo -n $PATH")))
;;   (setenv "PATH" path)
;;   (setq exec-path
;;         (append
;;          (Split-string-anD-unquote path ":")
;;          exec-path)))

;;;;;;;;;;;;;;;;;;;;;;
;; Other settings  ;;;
;;;;;;;;;;;;;;;;;;;;;;

;; Enabling line numbering in text editors
(global-display-line-numbers-mode)

;; Show matching parentheses
(show-paren-mode 1)

;; Enabling line wrap by default
(setq line-move-visual nil)

;; Setting up Emacs as an edit server, so that it `listens' for external edit requests and acts accordingly.
(require 'server)
(unless (server-running-p)
    (server-start))

;; Enable ESS
 (use-package ess
  :ensure t
  :init (require 'ess-site))

;; ESS indentation
(defun myindent-ess-hook ()
  (setq ess-indent-level 2)
  (setq ess-offset-arguments-newline '(prev-line 2))
)
(add-hook 'ess-mode-hook 'myindent-ess-hook)


;; Changing backup behavior to save to ~/.saves
(setq backup-directory-alist `(("." . "~/Dropbox/Documents/orglife/backup/.saves")))
(setq backup-by-copying t)
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)

;; Ensure environment variables inside Emacs look the same as in the user's shell.
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;;; Shell Configure
;; Ensure environment variables inside Emacs look the same as in the user's shell.
(use-package exec-path-from-shell
  :if (memq window-system '(mac ns))
  :config
  (exec-path-from-shell-initialize))


;; Remote file will be kept without testing if they still exists. Added in an
;; attempt to make emacs open/quit faster.
(setq recentf-keep '(file-remote-p file-readable-p))


;; Enabling access to list of recently edited files
(use-package recentf
  :config
  (setq recentf-max-saved-items 10000
        recentf-max-menu-items 5000
	recentf-save-file "~/.cache/emacs/recentf"
        ;; disable recentf-cleanup on Emacs start, because it can cause
        ;; problems with remote files
        recentf-auto-cleanup 'never)
  (recentf-mode +1))
(setq recentf-keep '(file-remote-p file-readable-p))

;; Automatically save recent files every 5 minutes.
(run-at-time (current-time) 300 'recentf-save-list)


; Allows colors in emacs M-x shell.
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(add-to-list 'comint-output-filter-functions 'ansi-color-process-output)


;; hide the startup message
(setq inhibit-startup-message t)
(setq inhibit-startup-screen t
      initial-buffer-choice  "~/Dropbox/Documents/orglife/todo.org")


;; Use ibuffer for better buffer management
(require 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer-other-window)
(setq ibuffer-default-sorting-mode 'major-mode) ;; I like to see my buffers
						;; sorted by major-mode, so I
						;; add this bit too:
(setq ibuffer-expert t) ;; prompt for confirmation only on modified buffers.


;; Coloring for shell?
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)


;; shell-mode
(defun sh ()
  (interactive)
  (ansi-term "/bin/zsh"))
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(add-to-list 'comint-output-filter-functions 'ansi-color-process-output)

;; (use-package dired
;;   :ensure t
;;   :config
;;   ;; dired - reuse current buffer by pressing 'a'
;;   (put 'dired-find-alternate-file 'disabled nil)

;;   ;; ;; always delete and copy recursively
;;   ;; (setq dired-recursive-deletes 'always)
;;   ;; (setq dired-recursive-copies 'always)

;;   ;; ;; if there is a dired buffer displayed in the next window, use its
;;   ;; ;; current subdir, instead of the current subdir of this dired buffer
;;   ;; (setq dired-dwim-target t)

;;   ;; ;; enable some really cool extensions like C-x C-j(dired-jump)
;;   ;; (require 'dired-x)
;;   )
;; Allows switch to sudo user when browsing "dired" buffers
(require 'dired)
(require 'dired-toggle-sudo)



;; Make cutting and pasting use the X clipboard.
(setq x-select-enable-clipboard t)


;; Enabling Helm
(helm-mode 1)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x .") 'helm-imenu-anywhere)
;; (global-set-key (kbd "C-x .") #'imenu-anywhere)


;; Enabling tab for completion in helm
(define-key helm-find-files-map "\t" 'helm-execute-persistent-action)


;; If the first two variables are set to something non-nil (e.g. t)
;; any space character in your search string will match any sequence
;; matched by the regular expression defined by the
;; search-whitespace-regexp variable.

;; A space character in your query will now match any space, tab, or linebreak any number of times.

;; To match words across line breaks do this (I'm not sure if this works)
(setq isearch-lax-whitespace t)
(setq isearch-regexp-lax-whitespace t)
(setq search-whitespace-regexp "[ \t\r\n]+")


;; Better window navigation
(global-set-key (kbd "M-o") 'ace-window)


;; ;; Enabling in-window editing for /google chrome/ (not used now)
;; (use-package 'edit-server)
;; (edit-server-start)


;; Helper to just swap the two windows
(defun win-swap () "Swap windows using buffer-move.el" (interactive) (if (null (windmove-find-other-window 'right)) (buf-move-left) (buf-move-right)))


;; ;; (add-hook 'org-mode-hook 'variable-pitch-mode)
;; (use-package mixed-pitch
;;   :hook
;;   ;; If you want it in all text modes:
;;   (org-mode . mixed-pitch-mode))


;; Turning off toolbar and menu bar
(tool-bar-mode -1)
(menu-bar-mode -1)


;; Allowing renaming of current buffer file, on the spot
(defun rename-current-buffer-file ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let* ((name (buffer-name))
        (filename (buffer-file-name))
        (basename (file-name-nondirectory filename)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (let ((new-name (read-file-name "New name: " (file-name-directory filename) basename nil basename)))
        (if (get-buffer new-name)
            (error "A buffer named '%s' already exists!" new-name)
          (rename-file filename new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil)
          (message "File '%s' successfully renamed to '%s'"
                   name (file-name-nondirectory new-name)))))))


;; Allows for embedded html images in EMACS
(defun replace-in-string (what with in)
  (replace-regexp-in-string (regexp-quote what) with in nil 'literal))


;; Use xdg-open on X. Not sure why it was needed.
(defun counsel-locate-action-extern (x)
  "Use xdg-open shell command on X."
  (call-process shell-file-name nil
                nil nil
                shell-command-switch
                (format "%s %s"
                        (if (eq system-type 'darwin)
                            "open"
                          "xdg-open")
                        (shell-quote-argument x))))



;; (setq-default line-spacing 1)
(defun toggle-line-spacing ()
  "Toggle line spacing between no extra space to extra half line height.
URL `http://ergoemacs.org/emacs/emacs_toggle_line_spacing.html'
Version 2017-06-02"
  (interactive)
  (if line-spacing
      (setq line-spacing nil)
    (setq line-spacing 0.5))
  (redraw-frame (selected-frame)))


;; Require ws-butler
(require 'ws-butler)
(add-hook 'prog-mode-hook #'ws-butler-mode)


;; Loads evil mode.
(require 'evil)
(evil-mode 1)

;; Enabling evil easy motion (easy ways to navigate)
(evilem-default-keybindings "SPC")


;; ;; Make the line number to alway show with same size, regardless of zoom in/out.
;; (set-face-attribute 'linum nil :height 120)
;; ((add-hook 'org-mode-hook (lambda () (display-line-number-mode 0)))
;; ((add-hook 'org-mode-hook (lambda () (linum-mode 1)))


;; Open html files in browser
(defun open-html()
  "Get the HTML file path & open it"
  (interactive)
  (let (html-file-path)
    (setq html-file-path (buffer-file-name))
    (shell-command (format "xdg-open '%s'" html-file-path)))
)

;; ;; Enables vim-type number increment/decrement in Evil
;; (define-key evil-normal-state-map (kbd "C-c +") 'evil-numbers/inc-at-pt)
;; (define-key evil-normal-state-map (kbd "C-c -") 'evil-numbers/dec-at-pt)

;; (define-key evil-visual-state-map (kbd "C-c +") 'evil-numbers/inc-at-pt)


;; (global-set-key (kbd "C-c +") 'evil-numbers/inc-at-pt)


;; Scrolling without moving point (cursor) [FYI I had to remove from mission
;; control ^up and ^down on my macbook for these to work.]
(defun gcm-scroll-down ()
  (interactive)
  (scroll-up 2))

(defun gcm-scroll-up ()
  (interactive)
  (scroll-down 2))

(global-set-key [(control down)] 'gcm-scroll-down)
(global-set-key [(control up)]   'gcm-scroll-up)


;; (global-unset-key (kbd "C-up"))
;; (define-key global-map (kbd "<S-up>") nil)



;; Current line highlighting!! This is great for latex editing, not so much for
;; org mode since various other things like checkboxes and coloring are masked.
;; (global-hl-line-mode 1)


;; Best search feature
(global-set-key (kbd "C-c h o") 'helm-occur)

;; Setting python3 to be default
;; (setq py-python-command "python3")
(setq py-python-command "/usr/bin/python3")

(defcustom python-shell-interpreter "python3"
  "Default Python interpreter for shell."
  :type 'string
  :group 'python)

 (setq python-shell-interpreter "/usr/bin/python3")


;; Putting the current buffer's file name on clipboard
(defun my-put-file-name-on-clipboard ()
  "Put the current file name on the clipboard"
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (with-temp-buffer
        (insert filename)
        (clipboard-kill-region (point-min) (point-max)))
 (message "Copied buffer file name '%s' to the clipboard." filename))))


;; Making the scratch buffer consistent
(persistent-scratch-setup-default)
(setq initial-major-mode 'org-mode)


;; Allows for code folding (i.e. "hide-show")
(add-hook 'prog-mode-hook #'hs-minor-mode)
(add-hook 'R-mode-common-hook #'hs-minor-mode)
(add-hook 'ess-mode-hook 'hs-minor-mode)

(global-set-key (kbd "C-+") 'hs-toggle-hiding)

;; Org-like hideshow behavior
(add-to-list 'load-path "~/repos/emacs-setup")
(add-to-list 'load-path "~/repos/emacs-setup/extra")
(require 'hideshow-org)


;; Make hide-show work in the middle of code blocks
(defun toggle-fold ()
  (interactive)
  (save-excursion
    (end-of-line)
    (hs-toggle-hiding)))


;; Makes buffer cycling via C-x <right> and C-x <left> *repeatable* i.e. C-x
;; <right> <right> <right> works.

;; The misc-cmds.el file is here:
;; https://www.emacswiki.org/emacs/download/misc-cmds.el
(load-library "~/repos/emacs-setup/misc-cmds.el")
(global-set-key [remap previous-buffer] 'previous-buffer-repeat)
(global-set-key [remap next-buffer]     'next-buffer-repeat)


;; Tramp and SSH
(setq tramp-default-method "ssh")
(setq tramp-verbose 6)
(setq helm-buffer-skip-remote-checking t) ;; from https://github.com/emacs-helm/helm/issues/749

(tramp-set-completion-function "ssh"
                               '((tramp-parse-sconfig "/etc/ssh_config")
                                 (tramp-parse-sconfig "~/.ssh/config")))
;; (Old) Tramp password is saved in
;; ~/.authinfo.gpg

;; In tramp, sometimes files cannot be run.
(setq tramp-inline-compress-start-size 1000000)




;; Trying out origami mode: https://github.com/gregsexton/origami.el
;; (use-package 'origami)
;; (use-package origami
;;   :ensure t
;;   :commands (origami-toggle-node)
;;   :bind* (("M-m -" . origami-toggle-node)))
;; (add-to-list 'origami-parser-alist '(R . origami-c-style-parser))


(use-package smooth-scrolling
  :config
  (smooth-scrolling-mode 1))


;; Set default
;; (set-frame-font "Inconsolata 12" nil t)
;; (set-frame-font "Liberation Mono-12:antialias=1")
;; (set-face-attribute 'default nil :font "Ubuntu Mono"
;; (set-face-attribute 'default nil
;; 		    :font "Liberation Mono-12:antialias=1"
;; 		    :extend t)
;; (set-frame-font "Liberation Mono-12:antialias=1",
;; 		:extend t
;; 		nil t)


(set-frame-font "Fantasque Sans Mono-12:antialias=1")



;;(set-frame-font "Inconsolata-12")



;; (custom-theme-set-faces
;;  'user
;;  '(variable-pitch ((t (:family "Open Sans" :height 180 :weight Regular))))
;;  '(fixed-pitch ((t ( :family "Inconsolata" :slant normal :weight normal :height 1.0 :width normal)))))

;; revive this!!!!
;; (set-frame-font "Inconsolata-12")

;; ;;Another way to do it.
;; (set-face-attribute 'default nil
;;                     :family "Inconsolata"
;;                     :height 120
;; 		    :width (quote condensed))
		    ;; :width (quote condensed))

;; (set-face-attribute 'default nil
;;                     :family "Ubuntu Mono"
;;                     :height 120
;; 		    :width (quote ExtraCondensed))




;; Smart Mode Line is a sexy mode-line for Emacs. It aims to be easy to read
;; from small to large monitors by using colors, a prefix feature, and smart
;; truncation.
(use-package smart-mode-line
  :config
  (setq sml/no-confirm-load-theme t)
  (setq sml/theme 'respectful)
  (sml/setup))



;; KILL current buffer file and close
;; based on http://emacsredux.com/blog/2013/04/03/delete-file-and-buffer/
(defun delete-current-file-and-buffer ()
  "Kill the current buffer and deletes the file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if filename
        (if (y-or-n-p (concat "Do you really want to delete file " filename " ?"))
            (progn
              (delete-file filename)
              (message "Deleted file %s." filename)
              (kill-buffer)))
      (message "Not a file visiting buffer!"))))


;; Increment number at selection
(defun increment-number-at-point ()
  (interactive)
  (skip-chars-backward "0-9")
  (or (looking-at "[0-9]+")
      (error "No number at point"))
  (replace-match (number-to-string (1+ (string-to-number (match-string 0))))))


;; Remove all newlines in region
(defun remove-newlines-in-region ()
  "Removes all newlines in the region."
  (interactive)
  (save-restriction
    (narrow-to-region (point) (mark))
    (goto-char (point-min))
    (while (search-forward "\n" nil t) (replace-match "" nil t))))
;; (global-set-key [f8] 'remove-newlines-in-region) ;; Not doing this


;; Experimental; trying to make typing/scrolling smoother
(setq redisplay-dont-pause t)
(require 'smooth-scrolling)
(smooth-scrolling-mode 1)


;; Use Python3 by default
(setq py-python-command "python3")
(put 'narrow-to-region 'disabled nil)


;(setq python-shell-interpreter "python3"
;      python-shell-interpreter-args "-i")
;(elpy-enable)


;; Load theme
;; (add-to-list 'custom-theme-load-path "~/repos/emacs-setup/themes/emacs-leuven-theme")
(load-theme 'leuven t)		                  ; For Emacs 24+.
;; (load-theme 'leuven-dark t)
;; (load-theme 'misterioso)
;; (use-package 'apropospriate)
;; (load-theme 'apropospriate-light t)
;; (load-theme 'apropospriate-dark t)


;; The vanilla undo/redo was not working well with evil mode, so this is a
;; workaround. undo-tree used to work out of the box, but now it doesn't.
;; Temporarily commenting this out..
;; (use-package undo-fu
;;   :config
;;   (global-undo-tree-mode -1)
;;   (define-key evil-normal-state-map "u" 'undo-fu-only-undo)
;;   (define-key evil-normal-state-map "\C-r" 'undo-fu-only-redo))

(use-package evil)
  ;; :init
  ;;  (setq evil-undo-system 'undo-fu))

(require 'undo-tree)
(global-undo-tree-mode)
(evil-set-undo-system 'undo-tree)

;; Prevent undo tree files from polluting your git repo
;; From here: https://www.reddit.com/r/emacs/comments/tejte0/undotree_bug_undotree_files_scattering_everywhere/
(setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))


;; (global-undo-tree-mode)
;; (evil-set-undo-system 'undo-tree)

;; (custom-set-variables '(evil-undo-system 'undo-tree))
;; (add-hook 'evil-local-mode-hook 'turn-on-undo-tree-mode)
;; (global-undo-tree-mode)
;; (add-hook 'evil-local-mode-hook 'turn-on-undo-tree-mode)


;; (require 'undo-tree)
;; (global-undo-tree-mode)
;; (add-hook 'evil-local-mode-hook 'turn-on-undo-tree-mode)



;; (use-package undo-fu
;;   :config
;;   (global-undo-tree-mode -1)
;;   (define-key evil-normal-state-map "u" 'undo-fu-only-undo)
;;   (define-key evil-normal-state-map "\C-r" 'undo-fu-only-redo))


;; ediff needs to be improved
;; See this for more tips https://oremacs.com/2015/01/17/setting-up-ediff/
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq ediff-diff-options "-w")


;; Making help faster (https://eklitzke.org/making-helm-projectile-find-file-fast-in-large-projects)
(setq projectile-enable-caching t)

;; Make shell pop
(global-set-key (kbd "<C-M-return>") 'shell-pop)

;; Still trying to speed up company mode from here: https://www.reddit.com/r/emacs/comments/m52nky/im_sorry_but_why_is_lspmode_and_company_so_slow/
;; https://www.monolune.com/articles/configuring-company-mode-in-emacs/
(setq company-idle-delay 0;; How long to wait before popping up
      company-minimum-prefix-length 2 ;; Show the menu after one key press
      )
(setq company-global-modes '(not r-mode))
(setq company-selection-wrap-around t)
; Use tab key to cycle through suggestions.
; ('tng' means 'tab and go')
(company-tng-configure-default)

;; Maybe we want to only trigger company mode using tabs.
;; This could also be useful https://emacs.stackexchange.com/questions/13286/how-can-i-stop-the-enter-key-from-triggering-a-completion-in-company-mode ;


;; Trying to split screens cleanly: https://stackoverflow.com/questions/1381794/too-many-split-screens-opening-in-emacs
(setq split-height-threshold 999)

;; ;; Whenever possible, split windows vertically by default
;; ;; (https://emacs.stackexchange.com/questions/39034/prefer-vertical-splits-over-horizontal-ones)
;; (defun split-window-sensibly-prefer-horizontal (&optional window)
;; "Based on split-window-sensibly, but designed to prefer a horizontal split,
;; i.e. windows tiled side-by-side."
;;   (let ((window (or window (selected-window))))
;;     (or (and (window-splittable-p window t)
;;          ;; Split window horizontally
;;          (with-selected-window window
;;            (split-window-right)))
;;     (and (window-splittable-p window)
;;          ;; Split window vertically
;;          (with-selected-window window
;;            (split-window-below)))
;;     (and
;;          ;; If WINDOW is the only usable window on its frame (it is
;;          ;; the only one or, not being the only one, all the other
;;          ;; ones are dedicated) and is not the minibuffer window, try
;;          ;; to split it horizontally disregarding the value of
;;          ;; `split-height-threshold'.
;;          (let ((frame (window-frame window)))
;;            (or
;;             (eq window (frame-root-window frame))
;;             (catch 'done
;;               (walk-window-tree (lambda (w)
;;                                   (unless (or (eq w window)
;;                                               (window-dedicated-p w))
;;                                     (throw 'done nil)))
;;                                 frame)
;;               t)))
;;      (not (window-minibuffer-p window))
;;      (let ((split-width-threshold 0))
;;        (when (window-splittable-p window t)
;;          (with-selected-window window
;;                (split-window-right))))))))

;; (defun split-window-really-sensibly (&optional window)
;;   (let ((window (or window (selected-window))))
;;     (if (> (window-total-width window) (* 2 (window-total-height window)))
;;         (with-selected-window window (split-window-sensibly-prefer-horizontal window))
;;       (with-selected-window window (split-window-sensibly window)))))

;; (setq
;;    split-height-threshold 4
;;    split-width-threshold 40
;;    split-window-preferred-function 'split-window-really-sensibly)


;; "Nice" writing environment. Distraction-free screen.
(use-package olivetti
  :init
  (setq olivetti-body-width 150))
;;   :config
;;   (defun distraction-free ()
;;     "Distraction-free writing environment"
;;     (interactive)
;;     (if (equal olivetti-mode nil)
;;         (progn
;;           (window-configuration-to-register 1)
;;           (delete-other-windows)
;;           (text-scale-increase 2)
;;           (olivetti-mode t))
;;       (progn
;;         (jump-to-register 1)
;;         (olivetti-mode 0)
;;         (text-scale-decrease 2))))
;;   :bind
;;   (("<f9>" . distraction-free)))

(require 'transpose-frame)


;; ;; Installing non-melpa packages. (doesn't work)
;; (use-package 'quelpa)
;; (use-package 'quelpa-use-package)
;; (unless (package-installed-p 'quelpa)
;;   (with-temp-buffer
;;     (url-insert-file-contents "https://raw.githubusercontent.com/quelpa/quelpa/master/quelpa.el")
;;     (eval-buffer)
;;     (quelpa-self-upgrade)))


;; ;; Installing dired+ directly (requires quelpa, which doesn't work)
;; (use-package dired+
;;   :quelpa (dired+ :fetcher url :url "https://www.emacswiki.org/emacs/download/dired+.el")
;;   :defer 1
;;   :init
;;   (setq diredp-hide-details-initially-flag nil)
;;   (setq diredp-hide-details-propagate-flag nil)

;;   :config
;;   (diredp-toggle-find-file-reuse-dir 1))


;; M-; stopped working on blocks of code, so I tried this
(defun xah-comment-dwim ()
  "Like `comment-dwim', but toggle comment if cursor is not at end of line.

URL `http://xahlee.info/emacs/emacs/emacs_toggle_comment_by_line.html'
Version 2016-10-25"
  (interactive)
  (if (region-active-p)
      (comment-dwim nil)
    (let (($lbp (line-beginning-position))
          ($lep (line-end-position)))
      (if (eq $lbp $lep)
          (progn
            (comment-dwim nil))
        (if (eq (point) $lep)
            (progn
              (comment-dwim nil))
          (progn
            (comment-or-uncomment-region $lbp $lep)
            (forward-line )))))))
(global-set-key (kbd "M-;") 'xah-comment-dwim)

;; Enabling repeated trashing of the same file (by creating temporary name).
(when (eq system-type 'darwin)
  (osx-trash-setup))
(setq delete-by-moving-to-trash t)

;; https://stackoverflow.com/questions/20510333/in-emacs-how-to-show-current-file-in-finder
(defun open-current-file-in-finder ()
  (interactive)
  (shell-command "open -R ."))


;; Scrollling more smoothly? over in-line org mode Images; only for EMACS 29, which breaks a bunch of things..
;; (pixel-scroll-precision-mode 1)


;;;; remove lockfile warning
;;;; https://emacs.stackexchange.com/questions/80439/error-warning-unlock-file-unlocking-file-invalid-argument-emacs-d-org-i
;;(setq-default create-lockfiles nil)
;;(setq create-lockfiles nil)

;; Also prevent warnings buffer from popping up all the time; also because EMACS29, I think.
;; https://emacs.stackexchange.com/questions/78800/how-to-disable-automatic-appearance-of-warnings-buffer-in-emacs
;; (setq warning-minimum-level :error)
;;(add-to-list 'warning-suppress-log-types '(unlock-file))
;;(add-to-list 'warning-suppress-types '(unlock-file))

;; trying this out next (global-auto-revert-mode t)
