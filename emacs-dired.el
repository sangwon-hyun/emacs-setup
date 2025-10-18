;; From here http://xahlee.info/emacs/emacs/emacs_dired_open_file_in_ext_apps.html

(defun xah-open-in-external-app (&optional @fname)
  "Open the current file or dired marked files in external app.
When called in emacs lisp, if @fname is given, open that.
URL `http://xahlee.info/emacs/emacs/emacs_dired_open_file_in_ext_apps.html'
Version 2019-11-04 2021-02-16"
  (interactive)
  (let* (
         ($file-list
          (if @fname
              (progn (list @fname))
            (if (string-equal major-mode "dired-mode")
                (dired-get-marked-files)
              (list (buffer-file-name)))))
         ($do-it-p (if (<= (length $file-list) 5)
                       t
                     (y-or-n-p "Open more than 5 files? "))))
    (when $do-it-p
      (cond
       ((string-equal system-type "windows-nt")
        (mapc
         (lambda ($fpath)
           (shell-command (concat "PowerShell -Command \"Invoke-Item -LiteralPath\" " "'" (shell-quote-argument (expand-file-name $fpath )) "'")))
         $file-list))
       ((string-equal system-type "darwin")
        (mapc
         (lambda ($fpath)
           (shell-command
            (concat "open " (shell-quote-argument $fpath))))  $file-list))
       ((string-equal system-type "gnu/linux")
        (mapc
         (lambda ($fpath) (let ((process-connection-type nil))
                            (start-process "" nil "xdg-open" $fpath))) $file-list))))))

(define-key dired-mode-map (kbd "<C-return>") 'xah-open-in-external-app)

;; https://www.masteringemacs.org/article/making-deleted-files-trash-can
(setq delete-by-moving-to-trash t)
(setq trashcan-dirname "~/.local/share/Trash/files")
(setq trash-directory "~/.Trash")




;; Making the dired buffer cleaner (by hiding miscellaneous files)
(require 'dired-x)
(setq dired-omit-files
    (rx (or (seq bol (? ".") "#")     ;; emacs autosave files
        (seq bol "." (not (any "."))) ;; dot-files
        (seq "~" eol)                 ;; backup-files
        (seq bol "CVS" eol)           ;; CVS dirs
        ))
    )
(setq-default dired-listing-switches "-alh")
(add-hook 'dired-mode-hook (lambda () (dired-omit-mode 1)))



;; I want to use "a" to be able to go to a new directory /without/ creating a new dired buffer.
;;https://www.emacswiki.org/emacs/DiredReuseDirectoryBuffer
(put 'dired-find-alternate-file 'disabled nil)

;; (require dired+)
(diredp-toggle-find-file-reuse-dir 1)
