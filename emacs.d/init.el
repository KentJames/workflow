;;:~(require 'package)
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; Activate all the packages (in particular autoloads)
(package-initialize)

;;Grep Default Command
(setq grep-command "grep -Er --color -nH")




;; Configurations for various things.

(require 'config-mac)
(require 'config-path)
(require 'config-tramp)
(require 'config-theme)

(require 'config-org)
(require 'config-notmuch)
(require 'config-gnus)
(require 'config-helm)
(require 'config-ycmd)
(require 'config-syntax)
(require 'config-jupyter)


;;; Package Manage and Emacs Section (Don't Edit)

; --- Packages

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
 '(org-agenda-files
   (quote
    ("~/git-working/WriteUps/Closure/closures.org" "~/git-working/WriteUps/ARM_SVE/arm_sve.org" "/Users/jameskent/git-working/WriteUps/W-Towers/wtowers.org" "/Users/jameskent/git-working/WriteUps/PhD-Thesis/thesis.org" "/Users/jameskent/git-working/WriteUps/org/capture.org" "/Users/jameskent/git-working/WriteUps/org/diary.org" "/Users/jameskent/git-working/WriteUps/org/notes.org" "/Users/jameskent/git-working/WriteUps/org/papers.org")))
 '(package-selected-packages
   (quote
    (org-plus-contrib offlineimap helm-notmuch notmuch csv-mode haskell-mode ein rust-mode flycheck-ycmd company-ycmd ycmd flycheck auctex xpm keychain-environment markdown-mode markdown-mode+ company-c-headers company-irony-c-headers company-irony typescript-mode irony ac-c-headers google-this auto-complete-c-headers auto-complete-auctex helm list-packages-ext cuda-mode ox-pandoc pandoc pandoc-mode babel company twilight-anti-bright-theme eyebrowse neotree projectile auto-complete magit color-theme-sanityinc-tomorrow ## solarized-theme auctex-lua exec-path-from-shell auctex-latexmk cdlatex elscreen-multi-term elscreen-persist elscreen-separate-buffer-list git gitter gnuplot latex-extra latex-math-preview latex-unicode-math-mode org-random-todo org-readme org-ref))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(put 'narrow-to-page 'disabled nil)
