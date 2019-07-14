;; - Jupyter Notebook

(require 'ein-jupyter)
;; Fill in your Jupyter directory here
(setq ein:jupyter-default-server-command "/Library/Frameworks/Python.framework/Versions/3.6/bin/jupyter")
(setq ein:jupyter-default-notebook-directory (file-truename "~/git-working/"))

(define-key ein:notebook-mode-map (kbd "M-[") 'python-nav-backward-sexp)
;;(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
;;(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
;;(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z


(provide 'config-jupyter)
