;; ESS company mode was prohibitively slow.. https://github.com/emacs-ess/ESS/issues/1062
;; Also here: https://emacs.stackexchange.com/questions/54220/company-mode-slow-in-ess
(setq ess-r--no-company-meta t)

;; Workaround for ESS's issue https://github.com/emacs-ess/ESS/issues/1074
(setq ess-ask-for-ess-directory nil)

;; Preventing Rhistory file from being created
(setq ess-history-file nil)

;; Trying to speed up the incredibly slow ESS + company (I think)
(setq ess-use-flymake nil)
(setq ess-eval-visibly-p nil)
