;; --- Packages
(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

;; Helper function to disable package refresh/download if internet is down.
(defun internet-up-p (&optional host)
  (= 0 (call-process "ping" nil nil nil "-c" "1" "-W" "1" 
                     (if host host "www.google.com"))))

(setq package-enable-at-startup nil)
(package-initialize)
(when
    (and (internet-up-p "www.orgmode.org")
	 (internet-up-p "www.melpa.org")
	 (internet-up-p "www.stable.melpa.org")
  (package-refresh-contents)))

(setq config-packages-list '(all-the-icons
			     company
			     company-c-headers
			     doom-themes
			     doom-modeline
			     flycheck
			     flycheck-haskell
			     flycheck-rust
			     gnuplot
			     helm
			     magit
			     org
			     org-bullets
			     org-ref
			     org-roam
			     pandoc
			     pandoc-mode
			     projectile
			     rainbow-delimiters
			     undo-tree
			     use-package
			     ycmd))


(dolist (pkg config-packages-list)
    (when (not (package-installed-p pkg)) (package-install pkg)))
			     
(provide 'config-packages)
