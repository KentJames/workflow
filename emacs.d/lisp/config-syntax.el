;;-------------------------------------------------------------
;;;    Myriad of Syntax Highlighting/Checking/Completion
;;-------------------------------------------------------------
(require 'use-package)
(require 'company-c-headers)
;; --- Magit Config

(global-set-key (kbd "C-c m") 'magit-status)

;;(add-hook 'ycmd-mode-hook 'flycheck-ycmd-setup)

(global-company-mode t)
;;(global-ycmd-mode t)
;;(add-hook 'after-init-hook #'global-ycmd-mode)


;; -- Common Lisp
(setq inferior-lisp-program "/usr/local/bin/sbcl")


;; -- Enable Flycheck on Everything.
(global-flycheck-mode t)
(add-to-list 'flycheck-clang-include-path "/opt/homebrew/include")
(add-to-list 'flycheck-clang-args "-I/opt/homebrew/include")
;; - C Languages

(setq-default c-basic-offset 4)
(add-hook 'c-mode-common-hook 'hs-minor-mode)
(use-package cc-mode
  :init
  (define-key c-mode-map  [(tab)] 'company-complete)
  (define-key c++-mode-map  [(tab)] 'company-complete))
(add-to-list 'company-backends 'company-c-headers)


(defun setup-flycheck-clang-project-path ()
  (let ((root (ignore-errors (projectile-project-root))))
    (when root
      (add-to-list 
       (make-variable-buffer-local 'flycheck-clang-include-path)
       root))))
(add-hook 'c-mode-common-hook 'setup-flycheck-clang-project-path)

;; - C++ Mode

(add-hook
 'c++-mode-hook
 (lambda() (when (file-remote-p default-directory) (company-mode -1))))
(add-hook 'c++-mode-hook (lambda () (add-to-list 'flycheck-clang-args "-std=c++20")))
(add-hook 'c++-mode-hook (lambda () (add-to-list 'flycheck-gcc-args "-std=c++20")))
(add-hook 'c++-mode-hook (lambda () (setq flycheck-clang-standard-library "libc++")))

;; - Python Config
(setq python-shell-interpreter "python3")
(setq python-indent-offset 4)
(add-to-list 'tab-stop-list '4)
(defun python-settings ()
  (setq tab-width 4))

(add-hook 'python-mode-hook 'python-settings)

;; - Haskell

(setq haskell-process-type 'stack-ghci)


(provide 'config-syntax)

