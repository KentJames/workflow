(defun local-gnus-summary-settings ()
  (local-set-key (kbd "*") 'gnus-summary-mark-as-processable))
(add-hook 'gnus-summary-mode-hook 'local-gnus-summary-settings)

(provide 'config-gnus)
