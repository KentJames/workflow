(require 'package)

; List the packages you want

; Add Melpa as the default Emacs Package repository
; only contains a very limited number of packages
(add-to-list 'package-archives
                          '("melpa" . "http://melpa.milkbox.net/packages/") t)

; Activate all the packages (in particular autoloads)
(package-initialize)

; Update your local package index
(unless package-archive-contents
  (package-refresh-contents))

;Uk Macbook keyboard fix...
;; Allow hash to be entered  
(global-xset-key (kbd "M-3") '(lambda () (interactive) (insert "#")))
;;Cmd is Ctrl and Vice Versa
(setq mac-command-modifier 'control)
(setq mac-control-modified 'meta)

;Force SCP For Tramp Mode
(setq tramp-copy-size-limit nil)

;Import my system path
(exec-path-from-shell-copy-env "PATH")

;Theme
(scroll-bar-mode -1)
(load-theme `twilight-anti-bright t)
(eyebrowse-mode t)
(tool-bar-mode -1)

					;(add-to-list 'default-frame-alist '(foreground-color . "#E"))
(set-background-color "#000000")
(add-to-list 'default-frame-alist '(background-color . "#000000"))

;Fix Latex-Mode
(add-hook 'doc-view-mode-hook 'auto-revert-mode)
(set-variable 'doc-view-continuous t)

;Define Org Mode File Path

(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setf org-agenda-files '("~/Google_Drive/org"))
(setq org-log-done t)
(setq org-startup-indented t)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("5e2dc1360a92bb73dafa11c46ba0f30fa5f49df887a8ede4e3533c3ab6270e08" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" default)))
 '(erc-modules
   (quote
    (autojoin button completion fill irccontrols list match menu move-to-prompt netsplit networks noncommands readonly ring services stamp track)))
 '(package-selected-packages
   (quote
    (company twilight-anti-bright-theme eyebrowse neotree projectile auto-complete magit color-theme-sanityinc-tomorrow ## solarized-theme auctex-lua exec-path-from-shell auctex-latexmk cdlatex elscreen-multi-term elscreen-persist elscreen-separate-buffer-list git gitter gnuplot latex-extra latex-math-preview latex-unicode-math-mode org-random-todo org-readme org-ref))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
