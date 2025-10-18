;; ;; Default settings
(with-eval-after-load 'org
  (setq org-startup-indented t) ; Enable `org-indent-mode' by default
  (add-hook 'org-mode-hook 'visual-line-mode))

(setq org-startup-folded t)


;; Force dependencies to be honored among org mode items
(setq org-enforce-todo-dependencies t)
(setq org-enforce-todo-checkbox-dependencies t)

;; ;; Set faces
;; (custom-set-faces
;;   '(org-level-1 ((t (:inherit outline-1 :weight semi-bold))))
;;   '(org-level-2 ((t (:inherit outline-2 :weight semi-bold))))
;;   '(org-level-3 ((t (:inherit outline-3 :weight semi-bold))))
;;   '(org-level-4 ((t (:inherit outline-4 :weight semi-bold))))
;;   '(org-level-5 ((t (:inherit outline-5 :weight semi-bold))))
;; )


;; Not about org mode, but about viewing pdf files in evince
(require 'openwith)
(openwith-mode t)
(setq openwith-associations '(("\\.pdf\\'" "evince" (file))))

;; ;; Making latex fragments bigger
(require 'ox)
(plist-put org-format-latex-options :scale 3) ;3 for QHD monitor, 5 for laptop
(setq org-latex-create-formula-image-program 'dvipng)
;; (setq org-latex-create-formula-image-program 'imagemagick)


;; Pre-setting the image width of a figure to nil so I can manually change it in
;; each org document.
(setq org-image-actual-width nil)
(setq org-latex-image-default-width "5cm")

;; (setq org-image-actual-width (list 400))

;; Include html image.
(defun org-html--format-image (source attributes info)
  (progn
    (setq source (replace-in-string "%20" " " source))
    (format "<img src=\"data:image/%s;base64,%s\"%s />"
            (or (file-name-extension source) "")
            (base64-encode-string
             (with-temp-buffer
               (insert-file-contents-literally source)
              (buffer-string)))
            (file-name-nondirectory source))))

;; Enable org md export via C-c C-e m m
(require 'ox-md nil t)

;; ;; Hide emphasis markers
;; (setq org-hide-emphasis-markers nil)

;; Highlighting of latex in org mode
(eval-after-load 'org
  '(setf org-highlight-latex-and-related '(latex)))
(eval-after-load 'org
  '(setf org-highlight-latex-fragments-and-specials t))

;; All todo files go here; only the html output goes in the actual folders.
(setq org-directory "~/Dropbox/Documents/orglife")
;; The archived things all go here.
(setq org-archive-location "~/Dropbox/Documents/orglife/archive.org::* From %s")
(setq org-agenda-files (list "~/Dropbox/Documents/orglife/todo.org"))
;; (setq org-agenda-files (list "/home/sangwonh/Desktop/temp-todo.org"))
;; ;; (format "%s/%s" org-base-path "notes.org")
;; ;; (concat ORG "::")

;; keybindings for org mode agenda
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-switchb)

(setq org-agenda-dim-blocked-tasks nil)

;; ;;; In org agenda -- leave in emacs mode but add j & k
;; (define-key org-agenda-mode-map "j" 'evil-next-line)
;; (define-key org-agenda-mode-map "k" 'evil-previous-line)


(eval-after-load 'org
      (lambda()

        ;; Some org-mode customization
        (setq org-src-fontify-natively t
              org-confirm-babel-evaluate nil
              org-src-preserve-indentation t)

        ;; (org-babel-do-load-languages
        ;;  'org-babel-load-languages '((python . t)))

        (org-babel-do-load-languages
          'org-babel-load-languages '((R . t)))
        (setq org-src-fontify-natively nil)
	))

(require 'org-timeline)
(add-hook 'org-agenda-finalize-hook 'org-timeline-insert-timeline :append)
(setq org-timeline-start-hour 7)




;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;                    ;;;;;;;;;;;;;;;;;;;;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;  ALL about ORG-REF ;;;;;;;;;;;;;;;;;;;;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;                    ;;;;;;;;;;;;;;;;;;;;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; ;; Several things required for org-ref
;; (require 'cl-lib)

;; ;; ;; Basic setup of org-ref
;; (setq org-ref-bibliography-notes "~/Dropbox/papers/notes.org"
;;       org-ref-default-bibliography '("~/Dropbox/papers/references.bib")
;;       org-ref-pdf-directory "~/Dropbox/papers/bibtex-pdfs/")
;; (unless (file-exists-p org-ref-pdf-directory)
;;   (make-directory org-ref-pdf-directory t))

;; ;; ;; Some requires for basic org-ref usage
;; ;; (use-package 'org-ref)
;; ;; (use-package 'org-ref-pdf)
;; ;; (use-package 'org-ref-url-utils)

;; ;; (setq org-latex-pdf-process
;; ;;       '("pdflatex -interaction nonstopmode -output-directory %o %f"
;; ;; 	"bibtex %b"
;; ;; 	"pdflatex -interaction nonstopmode -output-directory %o %f"
;; ;; 	"pdflatex -interaction nonstopmode -output-directory %o %f"))

;; ;; (setq bibtex-autokey-year-length 4
;; ;;       bibtex-autokey-name-year-separator "-"
;; ;;       bibtex-autokey-year-title-separator "-"
;; ;;       bibtex-autokey-titleword-separator "-"
;; ;;       bibtex-autokey-titlewords 2
;; ;;       bibtex-autokey-titlewords-stretch 1
;; ;;       bibtex-autokey-titleword-length 5)

;; ;; (use-package 'dash)
;; ;; (setq org-latex-default-packages-alist
;; ;;       (-remove-item
;; ;;        '("" "hyperref" nil)
;; ;;        org-latex-default-packages-alist))

;; ;; ;; Append new packages
;; ;; (add-to-list 'org-latex-default-packages-alist '("" "natbib" "") t)
;; ;; (add-to-list 'org-latex-default-packages-alist
;; ;; 	     '("linktocpage,pdfstartview=FitH,colorlinks,
;; ;; linkcolor=blue,anchorcolor=blue,
;; ;; citecolor=blue,filecolor=blue,menucolor=blue,urlcolor=blue"
;; ;; 	       "hyperref" nil)
;; ;; 	     t)


;; ;; ;; Make org-pdfview default
;; ;; (eval-after-load 'org '(require 'org-pdfview))
;; ;; ;; If you want, you can also configure the org-mode default open PDF file function.
;; ;; (add-to-list 'org-file-apps '("\\.pdf\\'" . (lambda (file link) (org-pdfview-open link))))

;; ;; ;; PDFs visited in Org-mode are opened in Evince (and not in the default choice)
;; ;; ;; https://stackoverflow.com/a/8836108/789593
;; ;; (add-hook 'org-mode-hook
;; ;;       '(lambda ()
;; ;;          (delete '("\\.pdf\\'" . default) org-file-apps)
;; ;;          (add-to-list 'org-file-apps '("\\.pdf\\'" . "evince %s"))))


;; ;; ;; linum clashes with pdf-tools, so only enabling it during prog-mode.
;; ;; (add-hook 'prog-mode-hook 'linum-on)

;; ;; Enabling github-style org html export
;; (eval-after-load "org"
;;   '(require 'ox-gfm nil t))
(eval-after-load "org"
  '(require 'ox-gfm nil t))

;; ;; Showing emacs what program (i.e. pand to use for markdown
;; (setq markdown-command "/usr/bin/pandoc")

;; ;; Org mode projects
;; (setq org-publish-project-alist
;;       '(

;;   ("org-website"
;;           ;; Path to your org files.
;;           :base-directory "~/Dropbox/Documents/orglife/"
;;           :base-extension "org"

;;           ;; Path to your Jekyll project.
;;           :publishing-directory "~/Dropbox/Documents/orglife/website"
;;           :recursive t
;;           ;; :publishing-function org-publish-org-to-html
;; 	  :publishing-function org-html-publish-to-html

;;           :headline-levels 4
;;           :html-extension "html"
;;           :body-only t ;; Only export section between <body> </body>
;;     )


;;     ("org-static-website"
;;           :base-directory "~/Dropbox/Documents/orglife/"
;;           :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|php"
;;           :base-directory "~/Dropbox/website/temp/"
;;           :recursive t
;;           :publishing-function org-publish-attachment)

;;     ("website" :components ("org-website" "org-static-website"))

;; ))

;; ;; Allow helm-bibtex search by keyword.
;; (setq bibtex-completion-additional-search-fields '(keywords))


;;;;;;;;;;;;;;;;;;;;;
;;   ORG AGENDA  ;;;;
;;;;;;;;;;;;;;;;;;;;;

(use-package org-super-agenda
  :ensure t
  ;; :disabled t
  :config
  (org-super-agenda-mode)
  (setq org-super-agenda-groups
        '(
	  ;; (:name "Today"  ; Optionally specify section name
	  ;; 	 :time-grid t  ; Items that appear on the time grid
	  ;; 	 :todo "TODAY")  ; Items that have this TODO keyword
          ;; (:name "Important tasks "
          ;;        :priority "A")
	  ;; (:name "Today"
	  ;; 	 :time-grid t)
          (:name "You promised"
		 :tag ("commit"))
	  (:name "Work"
                :tag ("research" "teaching" "usc" "cmu" "editorial" "software" "delphi" "grant" "service"))
	  (:name "Errands"
                :tag ("errands"))
	  (:discard (:anything))
          ))
  (org-agenda nil "a")
  )



;; Agenda view html export
(setq org-agenda-exporter-settings
      '((ps-number-of-columns 2)
        (ps-landscape-mode t)
        (org-agenda-add-entry-text-maxlines 5)
        (htmlize-output-type 'css)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Other org settings ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Mixed pitch for org mode.
(require 'mixed-pitch)

;; Settings for when and how to do
(setq org-log-into-drawer t)		;Insert into drawer.
(setq org-log-done 'time) 		;Track time of when item is done.
(setq org-todo-keywords
      '((sequence "TODO(t)" "INPROGRESS(i!)" "|" "DONE(d!)" "CANCELED(c@)" "STANDBY(s@/!)")))


(setq org-default-notes-file (concat org-directory "/todo.org"))
;; (setq org-default-notes-file (concat org-directory "/org-capture-notes.org"))

;; (setq org-refile-targets '((org-agenda-files . (:maxlevel . 2))))
(setq org-refile-targets  (quote (("todo.org" :maxlevel . 2))))
				  ;; ("meeting-notes.org" :level . 0)
				  ;; ("research-ideas.org" :level . 1))))
(setq org-reverse-note-order t)

(setq org-completion-use-helm nil)
(setq org-outline-path-complete-in-steps nil)
(setq org-refile-use-outline-path 'file)
(setq org-refile-allow-creating-parent-nodes 'confirm)
(setq org-deadline-warning-days 7)


;; Not about org mode itself, but allowing org-mode editing. Just use C-c \ to
;; toggle back and forth between org mode formatting.
;; https://github.com/QBobWatson/poporg
(use-package poporg
      :bind (("C-c /" . poporg-dwim)))

;; Reformat time stamps
(setq org-time-stamp-custom-formats
      '("<%d %b %Y>" . "<%d/%m/%y %a %H:%M>"))

;; Disabling certain commands because they are accidentally used sometimes and
;; it is super annoying.
(put 'org-columns 'disabled
     "You asked to go into org column view, but I'd bet it was a mistake!\n")

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;   Change background color of code blocks in org latex export   ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ;; From: https://emacs.stackexchange.com/questions/55755/change-background-color-of-code-block-for-org-mode-latex-export
;; ;; Scratch buffer.
;; (setq org-latex-listings t)
;; (add-to-list 'org-latex-packages-alist '("" "listings"))
;; (add-to-list 'org-latex-packages-alist '("" "color"))

;; ;;;; Do something like this:
;; ;; #+CAPTION: Caption, my caption!
;; ;; #+ATTR_LATEX: :options frame=single,backgroundcolor=\color{lightgray}
;; ;; #+BEGIN_SRC C :results output :exports both
;; ;; int i, x = 10;
;; ;; for(i = 0; i < x; i++)
;; ;;     printf("%d ",i);
;; ;; printf(" ~ %d\n", x);
;; ;; #+END_SRC


;; ;; Adding keyword TOC_NO_HEADING to html export keywords:
;; (push '(:html-toc-no-heading "TOC_NO_HEADING" nil nil t) (org-export-backend-options (org-export-get-backend 'html)))

;; (defun my-org-html-toc-no-heading (args)
;;   "Avoid toc heading in html export if the keyword TOC_HO_HEADING is t or yes.
;; Works as a :filter-args advice for `org-html-toc' with argument list ARGS."
;;   (let* ((depth (nth 0 args))
;;      (info (nth 1 args))
;;      (scope (nth 2 args)))
;;     (when (and (assoc-string (plist-get info :html-toc-no-heading) '(t yes) t)
;;            (null scope))
;;       (setq scope (plist-get info :parse-tree)))
;;     (list depth info scope)))

;; (advice-add 'org-html-toc :filter-args #'my-org-html-toc-no-heading)

;; ;; Preserving indentation
;; (setq org-src-preserve-indentation nil
;;       org-edit-src-content-indentation 0)

;; (setq org-hide-leading-stars t)

;; ;; You can use c-c c-x c-t to insert a 15-star item
;; (require 'org-inlinetask)

;; ;; Github-flavored markdown org export
;; (eval-after-load "org"
;;   '(require 'ox-gfm nil t))

;; ;; Also useful: open this filename
;; ;; (defun open-in-browser()
;; ;;   (interactive)
;; ;;   (let ((filename (buffer-file-name)))
;; ;;     (browse-url (concat "file://" filename))))

;; (defun open-in-browser()
;; "open buffer in browser, unless it is not a file. Then fail silently (ouch)."
;;   (interactive)
;;   (if (buffer-file-name)
;;       (let ((filename (buffer-file-name)))
;;         (shell-command (concat "google-chrome \"file://" filename "\"")))))

;; ;; Org-downlaod
;; (require 'org-download)
(use-package org-download
    :after org
    :defer nil
    :custom
    (org-download-method 'directory)
    ;; (org-download-image-dir "/home/sangwonh/Dropbox/Documents/orglife/figures")
    (org-download-heading-lvl nil)
    ;; (org-image-actual-width 1000)  ;; Also see this https://www.miskatonic.org/2016/08/25/image-display-size-in-org/
    :bind
    ("C-M-y" . org-download-screenshot)
    :config
    (require 'org-download))
(add-hook 'dired-mode-hook 'org-download-enable) ;; Drag-and-drop to `dired`



;; ;; ;; Promising but not tried yet: real-time rendering of LaTeX
;; ;; (add-hook 'org-mode-hook 'org-fragtog-mode)


;; I don't really like this anymore:
;; (use-package org-sticky-header
;;   :ensure t
;;   :hook (org-mode . org-sticky-header-mode))
;; (add-hook 'org-mode-hook 'org-sticky-header-mode) ;I think this is redundant



(setq org-latex-pdf-process
      '("latexmk -pdflatex='pdflatex -interaction nonstopmode' -pdf -bibtex -f %f"))


(unless (boundp 'org-latex-classes)
  (setq org-latex-classes nil))
(add-to-list 'org-latex-classes
             '("article"
               "\\documentclass[11pt,a4paper]{article}
\\usepackage[utf8]{inputenc}
\\usepackage[T1]{fontenc}
\\usepackage{fixltx2e}
\\usepackage{graphicx}
\\usepackage{longtable}
\\usepackage{float}
\\usepackage{wrapfig}
\\usepackage{rotating}
\\usepackage[normalem]{ulem}
\\usepackage{amsmath}
\\usepackage{textcomp}
\\usepackage{marvosym}
\\usepackage{wasysym}
\\usepackage{amssymb}
\\usepackage{hyperref}
\\usepackage{mathpazo}
\\usepackage{color}
\\usepackage{enumerate}
\\definecolor{bg}{rgb}{0.95,0.95,0.95}
\\tolerance=1000
      [NO-DEFAULT-PACKAGES]
      [PACKAGES]
      [EXTRA]
\\linespread{1.1}
\\hypersetup{pdfborder=0 0 0}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")))


;; (setq org-latex-pdf-process
;;     '("latexmk -pdflatex='pdflatex -interaction nonstopmode' -pdf -bibtex -f %f"))
(setq org-latex-pdf-process (list
   "latexmk -pdflatex='pdflatex -shell-escape -interaction nonstopmode' -pdf -f  %f"))

(require 'org-web-tools)
(require 'helm-org-rifle)

;; inserting links easily
(require 'org-cliplink)
(global-set-key (kbd "C-x p i") 'org-cliplink)


;; Making emacs open org agenda
(add-hook 'after-init-hook 'org-agenda-list)
(setq inhibit-splash-screen t)
(org-agenda-list)
(delete-other-windows)



;; ess console turns grey.. preventing this!
;; https://github.com/emacs-ess/ESS/issues/1193
(require 'xterm-color)
(defun my-inferior-ess-init ()
  "Workaround for https://github.com/emacs-ess/ESS/issues/1193"
  (add-hook 'comint-preoutput-filter-functions #'xterm-color-filter -90 t)
  (setq-local ansi-color-for-comint-mode nil))

(add-hook 'inferior-ess-mode-hook #'my-inferior-ess-init)
