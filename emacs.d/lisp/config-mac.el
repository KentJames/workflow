;;Uk Macbook keyboard fix...
;; Allow hash to be entered
(global-set-key (kbd "M-3") '(lambda () (interactive) (insert "#")))
;;Cmd is Ctrl and Vice Versa
;;(setq mac-command-modifier 'control)
(setq mac-control-modified 'meta)

(provide 'config-mac)
