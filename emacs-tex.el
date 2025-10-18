;; Everything about latex goes here.

;; (add-hook 'latex-mode-hook (lambda () (setq TeX-PDF-mode t))) ;Newly added
;; (setq-default TeX-PDF-mode t)

;; Enabling latex mode, using Alex Reinhart's settings
;; (defun setup-latex-mode ()
;;   (LaTeX-math-mode)
;;   (setq show-trailing-whitespace t)
;;   (flyspell-mode 1)
;;   (turn-on-auto-fill)
;;   (setq-local company-backends
;;   	      (append '((company-math-symbols-latex company-auctex-macros company-auctex-environments))
;;   		      company-backends)))


;; Loading some latex packages
(setq org-latex-packages-alist '(("" "unicode-math")))


;; (add-hook 'LaTeX-mode-hook 'setup-latex-mode)
(use-package tex
  :ensure auctex)

(add-hook 'after-init-hook 'global-company-mode)

(with-eval-after-load "tex"
  (TeX-global-PDF-mode 1))

;; enable jumping to latex source location in pdf
(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
(setq TeX-source-correlate-method 'auto)
(setq TeX-source-correlate-start-server t)

(custom-set-variables
     '(TeX-source-correlate-method 'synctex)
     '(TeX-source-correlate-mode t)
     '(TeX-source-correlate-start-server t))

 ;; '(TeX-view-program-selection
 ;;   (quote
 ;;    ((output-dvi "open")
 ;;     (output-pdf "Skim")
 ;;     (output-html "open"))))

(setq TeX-source-correlate-method 'synctex
      TeX-view-program-list   ;; Use Skim, it's awesome
      '(("Skim" "/Applications/Skim.app/Contents/SharedSupport/displayline -g -b %n %o %b"))
      TeX-view-program-selection '((output-pdf "Skim"))
      TeX-auto-save t
      TeX-parse-self t
      TeX-save-query nil
      TeX-master 'dwim)




;; https://emacs.stackexchange.com/questions/2604/debugging-server-related-warning-message
(require 'server)
(server-force-delete)  ;; WARNING: Kills any existing edit server


;; Using Evince (doesn't work)
;; (setq TeX-view-program-selection '((output-pdf "Evince")))
;; (setq TeX-view-program-list '(("Evince" "evince --page-index=%(outpage) %o")))
;; (add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)
;; (setq TeX-view-program-list '(("Evince" "evince %o")))


;; Using Evince
;; from: https://tex.stackexchange.com/questions/161797/how-to-configure-emacs-and-auctex-to-perform-forward-and-inverse-search
;; (if (eq system-type 'darwin)
;;     ;; Insert pdf viewer options for macos
;;     )

;; (with-system gnu/linux
;;   (setq TeX-view-program-selection '((output-pdf "Okular")))
;;   (setq TeX-view-program-list (quote (("Okular" "okular --unique %o#src:%n%b"))))
;;   (setq TeX-view-program-selection (quote ((engine-omega "dvips and gv") (output-dvi "xdvi") (output-pdf "Okular") (output-html "xdg-open"))))
;; )

;; enable line wrap
(setq-default fill-column 80)
(setq LaTeX-break-at-separators nil)

;; Org mode line wrap
;; (add-hook 'org-mode-hook
;; (define-key org-mode-map "\M-q" 'toggle-truncate-lines))


; If you use AUCTeX (you probably do; if you don't, you probably should):
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)


;; (setq TeX-PDF-mode t)                ; PDF mode (rather than DVI-mode)
;; This is required for compiling the thesis, but not for general tex files.

(setq latex-run-command "pdflatex") 	; Just use this.


;; Showing helm-bibtex where the bib files are:
(setq bibtex-completion-bibliography "~/Dropbox/papers/references.bib")
;; "/home/shyun/Dropbox/papers/all.bib"))

;; Specify where helm-bibtex can look for PDFs:
(setq bibtex-completion-library-path "~/Dropbox/papers/bibtex-pdfs")

;; Specify the field in bibtex entries locally linking to the pdf:
(setq bibtex-completion-pdf-field "file")

;; Specify which program will open the pdfs:
(setq bibtex-completion-pdf-open-function
  (lambda (fpath)
    (start-process "evince" "*helm-bibtex-evince*" "/usr/bin/evince" fpath)))

;; Only do one or the other
;; (helm-add-action-to-source
;;  "Open annotated PDF (if present)" 'helm-bibtex-open-annotated-pdf
;;  helm-source-bibtex 1)
(setq bibtex-completion-find-additional-pdfs t)


(defun helm-bibtex-open-annotated-pdf (key)
  (let ((pdf (car (helm-bibtex-find-pdf-in-library (s-concat key "-annotated")))))
    (if pdf
        (helm-bibtex-pdf-open-function pdf)
      (message "No annotated PDF found."))))


;; Additional useful things.
(setq bibtex-completion-bibliography "~/Dropbox/papers/references.bib"
      bibtex-completion-library-path "~/Dropbox/papers/bibtex-pdfs"
      bibtex-completion-notes-path "~/Dropbox/papers/helm-bibtex-notes.org")


;; open pdf with system pdf viewer (for linux)
(setq bibtex-completion-pdf-open-function
  (lambda (fpath)
    (call-process "evince" nil 0 nil fpath)))

;; alternative
;; (setq bibtex-completion-pdf-open-function 'org-open-file)

;; Allows C-c C-a for compiling.
(add-hook 'LaTeX-mode-hook #'latex-extra-mode)



;; Custom fontification
(setq font-latex-user-keyword-classes
      '(("mathcmds"  (("frac" "{{"))  bold-italic              command)
        ("mathnoarg" ("leq")          font-lock-warning-face   noarg)))


;; ;; Added quoted parentheses
;; (define-skeleton quoted-parentheses
;;   "Insert \\( ... \\)."
;;     nil "\\(" _ "\\)")
;; From here: https://www.emacswiki.org/emacs/AutoPairs#Discussion

(add-hook 'LaTeX-mode-hook 'turn-on-auto-fill)


;; Function to replace only math
(defun latex-replace-in-math ()
"Call `query-replace-regexp' with `isearch-filter-predicate' set to filter out matches outside LaTeX math environments."
(interactive)
(let ((isearch-filter-predicate
(lambda (BEG END)
(save-excursion (save-match-data (goto-char BEG) (texmathp)))))
(case-fold-search nil))
(call-interactively 'query-replace-regexp)))


;; In multi-file latex, query for master file.
(setq-default TeX-master t)

;; Still fixing TeX-Master problems
;; from here:
;; https://tex.stackexchange.com/questions/410393/how-to-properly-set-up-auctex-to-parse-macros-from-my-own-sty-files
(setq TeX-parse-self t)
(setq TeX-auto-save t)

;; This is the most helpful link:
;; https://tex.stackexchange.com/questions/470193/how-to-make-auctex-aware-of-the-class-in-the-master-file
