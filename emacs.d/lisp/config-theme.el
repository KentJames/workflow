;;Theme
(require 'doom-themes)
(scroll-bar-mode -1)
(load-theme `doom-one t)
(eyebrowse-mode t)
(tool-bar-mode -1)


;; Enable flashing mode-line on errors
(doom-themes-visual-bell-config)

;; Corrects (and improves) org-mode's native fontification.
(doom-themes-org-config)

(setq initial-buffer-choice 5)

(provide 'config-theme)



