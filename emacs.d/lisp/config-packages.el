;; --- Packages
(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)
(package-refresh-contents)

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
			     use-package
			     ycmd))

(dolist (pkg config-packages-list)
    (when (not (package-installed-p pkg)) (package-install pkg)))
			     







(provide 'config-packages)
