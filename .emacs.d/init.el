:~(require 'package)

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
(global-set-key (kbd "M-3") '(lambda () (interactive) (insert "#")))
;;Cmd is Ctrl and Vice Versa
(setq mac-command-modifier 'control)
(setq mac-control-modified 'meta)

;;Tramp Settings
;; Force SCP For Tramp Mode
(setq tramp-copy-size-limit nil)

;Import my system path
(exec-path-from-shell-initialize)
(exec-path-from-shell-copy-env "PATH")
(exec-path-from-shell-copy-env "LD_LIBRARY_PATH")

;Theme
(scroll-bar-mode -1)
(load-theme `twilight-anti-bright t)
(eyebrowse-mode t)
(tool-bar-mode -1)

					;(add-to-list 'default-frame-alist '(foreground-color . "#E"))
(set-background-color "#FFFFFF")
(add-to-list 'default-frame-alist '(background-color . "#000000"))

;Fix Latex-Mode    
(add-hook 'doc-view-mode-hook 'auto-revert-mode)
(set-variable 'doc-view-continuous t)

;Define Org Mode File Path

(require 'org)
(require 'org-ref)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setf org-agenda-files '("~/git-working/WriteUps/org"))
(setq org-log-done t)
(setq org-startup-indented t)
(setq org-pretty-entities t)
(setq org-pretty-entities-include-sub-superscripts t)

					;(setq org-latex-pdf-process (list "latexmk -shell-escape -bibtex -f -pdf %f"))
(setq org-latex-pdf-process
      '("pdflatex -interaction nonstopmode -output-directory %o %f"
	"bibtex %b"
	"pdflatex -interaction nonstopmode -output-directory %o %f"
	"pdflatex -interaction nonstopmode -output-directory %o %f"))
; --- Auto Completion

;(require 'auto-complete)
;
;(defun auto-complete-mode-maybe ()
;  "No maybe for you. Only AC!"
;  (unless (minibufferp (current-buffer))
;;    (auto-complete-mode 1)))

;; --- Magit Config

(global-set-key (kbd "C-c m") 'magit-status)

;; --- Irony Config

(add-to-list 'auto-mode-alist '("\\.cu\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cuh\\'" . c++-mode))

;; --- Company on everything.
(global-company-mode 1)
;; --- Language Mode Hooks 
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)
(add-hook 'cuda-mode-hook 'irony-mode)

(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))
(add-hook 'irony-mode-hook #'my-irony-mode-hook)
(add-hook 'irony-mode-hook #'irony-cdb-autosetup-compile-options)

(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
(eval-after-load 'company
  '(add-to-list 'company-backends '(company-irony-c-headers company-irony))) 


;; --- Setup CUDA


(setq gud-gdb-command-name "cuda-gdb --annotate=3")


; --- Helm Config

(require 'helm)
(require 'helm-config)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)



(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z




(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t
      helm-echo-input-in-header-line t)

(defun spacemacs//helm-hide-minibuffer-maybe ()
  "Hide minibuffer in Helm session if we use the header line as input field."
  (when (with-helm-buffer helm-echo-input-in-header-line)
    (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
      (overlay-put ov 'window (selected-window))
      (overlay-put ov 'face
                   (let ((bg-color (face-background 'default nil)))
                     `(:background ,bg-color :foreground ,bg-color)))
      (setq-local cursor-type nil))))


(add-hook 'helm-minibuffer-set-up-hook
          'spacemacs//helm-hide-minibuffer-maybe)

(setq helm-autoresize-max-height 0)
(setq helm-autoresize-min-height 20)


(helm-autoresize-mode -1)
(helm-mode 1)

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
    ("~/git-working/WriteUps/W-Towers/wtowers.org" "/Users/jameskent/git-working/WriteUps/org/notes.org" "/Users/jameskent/git-working/WriteUps/org/todo.org")))
 '(package-selected-packages
   (quote
    (keychain-environment markdown-mode markdown-mode+ company-c-headers company-irony-c-headers company-irony typescript-mode irony ac-c-headers google-this auto-complete-c-headers auto-complete-auctex helm list-packages-ext cuda-mode ox-pandoc pandoc pandoc-mode babel company twilight-anti-bright-theme eyebrowse neotree projectile auto-complete magit color-theme-sanityinc-tomorrow ## solarized-theme auctex-lua exec-path-from-shell auctex-latexmk cdlatex elscreen-multi-term elscreen-persist elscreen-separate-buffer-list git gitter gnuplot latex-extra latex-math-preview latex-unicode-math-mode org-random-todo org-readme org-ref))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
