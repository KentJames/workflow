;;-------------------------------------------------------------
;;;    Myriad of Syntax Highlighting/Checking/Completion
;;-------------------------------------------------------------

;; --- Magit Config

(global-set-key (kbd "C-c m") 'magit-status)

;;(add-hook 'ycmd-mode-hook 'flycheck-ycmd-setup)

(global-company-mode t)
;;(global-ycmd-mode t)
;;(add-hook 'after-init-hook #'global-ycmd-mode)


;; -- Enable Flycheck on Everything.

(global-flycheck-mode t)

;; - C Indentation

(setq-default c-basic-offset 4)


;; --- Setup CUDA

(setq gud-gdb-command-name "cuda-gdb --annotate=3")

;; - Python Config

(setq python-indent-offset 4)
(add-to-list 'tab-stop-list '4)
(defun python-settings ()
  (setq tab-width 4))
  ;(local-set-key (kbd "C-c C-p 3" ) run-python("python3 -i" t t))
  ;(local-set-key (kbd "C-c C-p 2" ) run-python("python -i" t t)))

(add-hook 'python-mode-hook 'python-settings)

;; - Haskell

(setq haskell-process-type 'stack-ghci)


(provide 'config-syntax)

