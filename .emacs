;; Let's exclude this and see what happens. (ido-mode t)
;; Packages in emacs
(require 'package)
(setq package-archives
      '(("melpa-stable" . "https://stable.melpa.org/packages/")
	("melpa"        . "https://melpa.org/packages/")
	("gnu"          . "https://elpa.gnu.org/packages/")
	("org"          . "http://orgmode.org/elpa/")
	))
;; (package-initialize)

;; Loads evil mode.
;; Tab wasn't behaving correctly in org mode.
(setq evil-want-C-i-jump nil)
(require 'evil)
(evil-mode 1)


;;; I prefer cmd key for meta,
(setq mac-option-key-is-meta nil
      mac-command-key-is-meta t
      mac-command-modifier 'meta
      mac-option-modifier 'none)

;;; I prefer to use fn key as ctrl (like all sane human beings),
(setq ns-function-modifier 'control)

;; ;; Font (sample)
;; (set-frame-font "Inconsolata 12" nil t)


;; Placing some .el files here.

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; (package-initialize)

(add-to-list 'load-path "~/emacs/")


;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load all el files ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;

;; load in customizations
(load-library "~/repos/emacs-setup/emacs-general.el")
(load-library "~/repos/emacs-setup/emacs-misc.el")
(load-library "~/repos/emacs-setup/emacs-org.el")
(load-library "~/repos/emacs-setup/emacs-org-capture.el")
(load-library "~/repos/emacs-setup/emacs-R.el")
(load-library "~/repos/emacs-setup/emacs-ess.el")
(load-library "~/repos/emacs-setup/emacs-gnus.el")
(load-library "~/repos/emacs-setup/emacs-tex.el")
(load-library "~/repos/emacs-setup/emacs-magit.el")
(load-library "~/repos/emacs-setup/emacs-dired.el")
(load-library "~/repos/emacs-setup/emacs-rmd.el")

;; Open todo file by default
;; (find-file "~/Dropbox/Documents/orglife/todo.org")

;;;;;;;;;;;;;;;;
;; OTHER ;;;;;;;
;;;;;;;;;;;;;;;;


;; (eval-after-load 'latex-extra
;;   '(define-key latex-extra-mode-map (kbd "TAB") #'latex/hide-show))


;; Setting up LaTeX viewer
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-source-correlate-method 'synctex)
 '(TeX-source-correlate-mode t)
 '(TeX-source-correlate-start-server t)
 '(TeX-view-program-list
   '(("Skim"
      ("/Applications/Skim.app/Contents/SharedSupport/displayline -b -g %n %o %b"))))
 '(TeX-view-program-selection
   '((output-dvi "open")
     (output-pdf "Skim")
     (output-html "open")))
 '(custom-enabled-themes '(smart-mode-line-respectful leuven))
 '(custom-safe-themes '(default))
 '(org-download-heading-lvl nil nil nil "Customized with use-package org-download")
 '(org-download-image-dir "~/Dropbox/Documents/orglife/figures" nil nil "Customized with use-package org-download")
 '(org-download-method 'directory nil nil "Customized with use-package org-download")
 '(package-selected-packages
   '(quarto-mode osx-trash xterm-color dired+ quelpa-use-package quelpa format-all helm-swoop org-preview-html undo-redo org-sticky-header olivetti electric-spacing org-cliplink poly-R weblorg org-timeline helm-org-rifle org-web-tools unfill openwith chess auctex elgrep flycheck undo-tree shell-pop undo-fu ox-gfm ess ac-helm company-auctex poly-org markdown-mode+ leuven-theme company gnu-elpa-keyring-update org jemdoc-mode org-gcal apropospriate-theme humanoid-themes smart-mode-line transpose-frame stan-snippets flycheck-stan eldoc-stan company-stan stan-mode zpresent origami esup persistent-scratch wrap-region xah-lookup ws-butler use-package ts smooth-scrolling org-super-agenda org-ref org-plus-contrib org-pdfview org-download mixed-pitch magit latex-extra imenu-list imenu-anywhere evil-numbers evil-easymotion evil epresent elpy ein dired-toggle darkroom auctex-latexmk ace-window))
 '(send-mail-function 'smtpmail-send-it)
 '(sml/no-confirm-load-theme t)
 '(sml/theme 'respectful)
 '(warning-suppress-types '(((package reinitialization)))))


;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(fixed-pitch ((t (:family "Inconsolata" :slant normal :weight normal :height 1.0 :width normal))))
;;  '(org-level-1 ((t (:inherit outline-1 :weight semi-bold))))
;;  '(org-level-2 ((t (:inherit outline-2 :weight semi-bold))))
;;  '(org-level-3 ((t (:inherit outline-3 :weight semi-bold))))
;;  '(org-level-4 ((t (:inherit outline-4 :weight semi-bold))))
;;  '(org-level-5 ((t (:inherit outline-5 :weight semi-bold))))
;;  '(variable-pitch ((t (:family "Open Sans" :height 180 :weight Regular)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
