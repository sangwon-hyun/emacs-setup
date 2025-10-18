;; Gmail using gnus: a lot of this is from here:
;; https://github.com/brenns10/emacs/blob/master/gnus.org
(setq user-mail-address "robohyun66@gmail.com"
      user-full-name "Sangwon Hyun")


(setq gnus-select-method
      '(nnimap "gmail"
	       (nnimap-address "imap.gmail.com")  ; it could also be imap.googlemail.com if that's your server.
	       (nnimap-server-port "imaps")
	       (nnimap-stream ssl)))

(setq smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587)
      ;; gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]")

;; (setq gnus-select-method '(nntp "news.yourprovider.net"))

; http://groups.google.com/group/gnu.emacs.gnus/browse_thread/thread/a673a74356e7141f
(when window-system
  (setq gnus-sum-thread-tree-indent "  ")
  (setq gnus-sum-thread-tree-root "") ;; "● ")
  (setq gnus-sum-thread-tree-false-root "") ;; "◯ ")
  (setq gnus-sum-thread-tree-single-indent "") ;; "◎ ")
  (setq gnus-sum-thread-tree-vertical        "│")
  (setq gnus-sum-thread-tree-leaf-with-other "├─► ")
  (setq gnus-sum-thread-tree-single-leaf     "╰─► "))
(setq gnus-summary-line-format
      (concat
       "%0{%U%R%z%}"
       "%3{│%}" "%1{%d%}" "%3{│%}" ;; date
       "  "
       "%4{%-20,20f%}"               ;; name
       "  "
       "%3{│%}"
       " "
       "%1{%B%}"
       "%s\n"))
(setq gnus-summary-display-arrow t)



(setq gnus-parameters
  '((".*"
     (display . all)
     (gnus-use-scoring nil))))
(setq gnus-permanently-visible-groups "INBOX")

(setq gnus-thread-sort-functions
  '(gnus-thread-sort-by-most-recent-number))

(setq gnus-activate-level 1)

(setq gnus-interactive-exit nil)
(add-hook 'kill-emacs-hook (lambda ()
                            (when (boundp 'gnus-group-exit)
                                 (gnus-group-exit))))

(setq gnus-use-full-window nil)
