;; -- YCMD Setup
(require 'ycmd)
(setq ycmd-server-command
      (list "python3" "-u" (file-truename "~/.emacs.d/ycmd/ycmd/")))
(setq ycmd-global-config (file-truename "~/.emacs.d/ycmd/cpp/ycm/.ycm_extra_conf.py"))
(add-hook 'ycmd-mode-hook 'company-ycmd-setup)

(provide 'config-ycmd)
