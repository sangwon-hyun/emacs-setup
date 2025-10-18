;; Polymode, which allows for em
(defun rmd-mode ()
  "ESS Markdown mode for rmd files"
  (interactive)
  ;; Commented out because the package has a /flat/ file structure 
  ;; (setq load-path 
  ;;   (append (list "path/to/polymode/" "path/to/polymode/modes/")
  ;;       load-path))
  (require 'poly-R)
  (require 'poly-markdown)     
  (poly-markdown+r-mode))

;; Automatically switch to polymode when an rmd file is opened.
(add-to-list 'auto-mode-alist '("\\.Rmd" . poly-markdown+r-mode))


;; Make cursor scroll down automatically after evaluation, for R
(setq comint-scroll-to-bottom-on-input t)
(setq comint-scroll-to-bottom-on-output t)
(setq comint-move-point-for-output t)

;; Prevent underscore from making "<-".
(require 'ess-site)
; (ess-toggle-underscore nil) 		; It seems we don't need this anymore.

;; Make indent level 2
(setq ess-default-style 'GNU)

;; ;; Automatic spaceing (something is off, but this is promising)
;; (add-hook 'R-mode-hook #'electric-operator-mode)
;; (require 'electric-spacing)

;; (with-eval-after-load 'electric-operator-mode
;;   (electric-operator-add-rules-for-mode 'ess-mode
;; 					(cons "<-" " <- ")
;; 					(cons "->" " -> ")
;; 					(cons "%>%" " %>% ")
;; 					(cons "<" nil)))


;; load the library
(require 'quarto-mode)

;; Note that the following is not necessary to run quarto-mode in .qmd files! It's merely illustrating
;; how to associate different extensions to the mode.
(add-to-list 'auto-mode-alist '("\\.Rmd\\'" . poly-quarto-mode))

;; Or, with use-package:
(use-package quarto-mode
  :mode (("\\.Rmd" . poly-quarto-mode))
  )
