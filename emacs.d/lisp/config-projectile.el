(require 'projectile)

(projectile-mode +1)
;; Recommended keymap prefix on macOS
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

(provide 'config-projectile)
