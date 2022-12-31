; --- Packages
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(defun setup-frame (&optional frame)
  (set-frame-font "Droid Sans Mono for Powerline-13" 0 t))  

 (if (daemonp)
     (add-hook 'after-make-frame-functions #'setup-frame)
   (setup-frame))

(add-to-list 'auto-mode-alist '("\\.pdf\\'" . pdf-view-mode))


(setq inhibit-startup-message t)
(setq inhibit-splash-screen t)
(setq initial-scratch-message nil)

(require 'config-packages)   
(require 'config-mac)
(require 'config-path)
(require 'config-tramp)
(require 'config-theme) 
(require 'config-faces)
(require 'config-frame)
(require 'config-org) 
(require 'config-helm) 
(require 'config-ycmd) 
(require 'config-cedet) 
(require 'config-projectile)
(require 'config-syntax) 
(require 'config-utility)

(setq pdf-info-epdfinfo-program "/usr/local/bin/epdfinfo")

(provide 'init)
;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(pandoc-mode pandoc ycmd use-package skewer-mode projectile org-roam org-ref org-bullets markdown-mode magit julia-mode helm-git-grep helm gnuplot flycheck-rust flycheck-haskell ein doom-themes doom-modeline docker-compose-mode company-c-headers all-the-icons)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ein:cell-output-area ((t (:background "red"))) t))
