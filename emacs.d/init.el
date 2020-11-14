;;:~(require 'package)
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "cuda-mode" user-emacs-directory))
(add-to-list 'load-path "~/.emacs.d/vendor/emacs-powerline")
;;(load-file (expand-file-name "cuda-mode/cuda-mode.el" user-emacs-directory))
;; Activate all the packages (in particular autoloads)
(package-initialize)

;;Grep Default Command
(setq grep-command "grep -Er --color -nH")


(defun setup-frame (&optional frame)
  (set-frame-font "Droid Sans Mono for Powerline-13" 0 t))  

(if (daemonp)
    (add-hook 'after-make-frame-functions #'setup-frame)
  (setup-frame))
(setq sml/no-confirm-load-theme t)
(sml/setup)
(setq sml/theme 'dark)

(add-to-list 'auto-mode-alist '("\\.pdf\\'" . pdf-view-mode))


(setq inhibit-startup-message t)
(setq inhibit-splash-screen t)
(setq initial-scratch-message nil)

(require 'config-mac)
(require 'config-path)
(require 'config-tramp)
(require 'config-theme)
(require 'config-faces)
(require 'config-frame)
;;(require 'config-notmuch)
(require 'config-msmtp)
(require 'config-mu4e)
(require 'config-org)
;;(require 'config-gnus)
(require 'config-helm)
(require 'config-ycmd)
(require 'config-syntax)
(require 'config-jupyter)

(setq pdf-info-epdfinfo-program "/usr/local/bin/epdfinfo")


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
   '("3577ee091e1d318c49889574a31175970472f6f182a9789f1a3e9e4513641d86" "fe94e2e42ccaa9714dd0f83a5aa1efeef819e22c5774115a9984293af609fce7" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "38631c6d2f5c71c16b8cfdba0e282d4f918a07da3577435894d2e80ab9dcf14a" "84508a4c4b0cccdb89c98ae39438d792003826e1d371b75b706d74826048f0fb" "d64b20a5b3c0abc22a5f0945a4e4aa7dd25f971e587a760316a73ca851d7e82f" "6b2636879127bf6124ce541b1b2824800afc49c6ccd65439d6eb987dbf200c36" "1c082c9b84449e54af757bcae23617d11f563fc9f33a832a8a2813c4d7dfb652" "a3fa4abaf08cc169b61dea8f6df1bbe4123ec1d2afeb01c17e11fdc31fc66379" "b54826e5d9978d59f9e0a169bbd4739dd927eead3ef65f56786621b53c031a7c" "d2e9c7e31e574bf38f4b0fb927aaff20c1e5f92f72001102758005e53d77b8c9" "5e2dc1360a92bb73dafa11c46ba0f30fa5f49df887a8ede4e3533c3ab6270e08" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" default))
 '(ediff-window-setup-function 'ediff-setup-windows-plain)
 '(erc-modules
   '(autojoin button completion fill irccontrols list match menu move-to-prompt netsplit networks noncommands readonly ring services stamp track))
 '(minimap-major-modes '(cuda-mode prog-mode))
 '(minimap-mode nil)
 '(org-agenda-files
   '("/Users/jameskent/git-working/WriteUps/org/notes.org" "~/git-working/WriteUps/Closure/closures.org" "~/git-working/WriteUps/ARM_SVE/arm_sve.org" "/Users/jameskent/git-working/WriteUps/W-Towers/wtowers.org" "/Users/jameskent/git-working/WriteUps/PhD-Thesis/thesis.org" "/Users/jameskent/git-working/WriteUps/org/capture.org" "/Users/jameskent/git-working/WriteUps/org/diary.org" "/Users/jameskent/git-working/WriteUps/org/papers.org"))
 '(package-selected-packages
   '(org-bullets all-the-icons-dired doom-modeline slime smart-mode-line-powerline-theme smart-mode-line-atom-one-dark-theme smart-mode-line org-noter org-pdfview pdf-tools powerline counsel-etags undo-propose poet-theme org-dashboard yaml-mode doom-themes flycheck-haskell interleave minimap flycheck-rust org-plus-contrib offlineimap csv-mode haskell-mode ein rust-mode flycheck-ycmd company-ycmd ycmd flycheck auctex xpm keychain-environment markdown-mode markdown-mode+ company-c-headers company-irony-c-headers company-irony typescript-mode irony ac-c-headers google-this auto-complete-c-headers auto-complete-auctex helm list-packages-ext ox-pandoc pandoc pandoc-mode babel company twilight-anti-bright-theme eyebrowse neotree projectile auto-complete magit color-theme-sanityinc-tomorrow ## solarized-theme auctex-lua exec-path-from-shell auctex-latexmk cdlatex elscreen-multi-term elscreen-persist elscreen-separate-buffer-list git gitter gnuplot latex-extra latex-math-preview latex-unicode-math-mode org-random-todo org-readme org-ref))
 '(tool-bar-mode nil))



(put 'narrow-to-page 'disabled nil)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ein:cell-output-area ((t (:background "red"))) t)
 '(message-mml ((t (:foreground "#FF00" :slant italic))))
 '(notmuch-message-summary-face ((t (:foreground "#3ff"))))
 '(notmuch-wash-cited-text ((t (:foreground "#f09fff")))))

(provide 'init)

;;; init.el ends here
(put 'downcase-region 'disabled nil)
