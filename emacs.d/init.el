:~(require 'package)


;;-------------------------------------------------------------
;;; My init.el file. James Kent 2018.
;;; Initial Package Imports
;;-------------------------------------------------------------

;; Add Melpa as the default Emacs Package repository
;; only contains a very limited number of packages
(add-to-list 'package-archives
                          '("melpa" . "http://melpa.milkbox.net/packages/") t)

;; Activate all the packages (in particular autoloads)
(package-initialize)

;; Update your local package index
(unless package-archive-contents
  (package-refresh-contents))


;;; Various useability modifications for my local computer.

;;Uk Macbook keyboard fix...
;; Allow hash to be entered
(global-set-key (kbd "M-3") '(lambda () (interactive) (insert "#")))
;;Cmd is Ctrl and Vice Versa
(setq mac-command-modifier 'control)
(setq mac-control-modified 'meta)

;;Tramp Settings
;; Force SCP For Tramp Mode

(require 'tramp)
;;(add-to-list 'tramp-connection-properties
;;    (list (regexp-quote "/ssh:@maurice.ra.phy.private.cam.ac.uk:")
;;        "login-args" '("-A")))
(defun add-ssh-agent-to-tramp ()
  (cl-pushnew '("-A")
              (cadr (assoc 'tramp-login-args
                           (assoc "ssh" tramp-methods)))
              :test #'equal))
(add-ssh-agent-to-tramp)
;;(add-to-list 'tramp-remote-path 'tramp-own-remote-path)

;;Interactive shells
(setq shell-command-switch "-ic")


;;Import my system path
(exec-path-from-shell-initialize)
(exec-path-from-shell-copy-env "PATH")
(exec-path-from-shell-copy-env "LD_LIBRARY_PATH")

;;Grep Default Command
(setq grep-command "grep -Er --color -nH")

;;Theme
(scroll-bar-mode -1)
(load-theme `twilight-anti-bright t)
(eyebrowse-mode t)
(tool-bar-mode -1)

;;-------------------------------------------------------------
;;; Documentation and Org-Mode Settings
;;--------------------------------------------------------------

;;Fix Latex-Mode
(add-hook 'doc-view-mode-hook 'auto-revert-mode)
(set-variable 'doc-view-continuous t)
(setq reftex-default-bibliography '("~/git-working/WriteUps/references_all.bib"))
(setq reftex-plug-into-AUCTeX t)
;; Org Mode Settings

(require 'org)
(require 'org-ref)
(require 'org-capture)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-directory "~/git-working/WriteUps/org")
(setq org-default-notes-file (concat org-directory "/capture.org"))
(setq org-archive-location (concat org-directory "/archive.org_archive"))
(define-key global-map "\C-cc" 'org-capture)
(setq org-log-done t)
(setq org-startup-indented t)
(setq org-pretty-entities nil)
(setq org-pretty-entities-include-sub-superscripts nil)
(setq org-todo-keywords '((sequence "TODO" "INPROGRESS" "|" "DONE" "CANCELLED")
			   ))
(setq org-capture-templates
       '(("t" "TODO" entry (file org-default-notes-file)
	  "* TODO %?\n%u\n%a\n" :clock-in t :clock-resume t)
	 ("m" "Meeting" entry (file+datetree "~/git-working/WriteUps/org/diary.org")
	  "* MEETING with %? :MEETING:\n%t" :clock-in t :clock-resume t)
	 ("d" "Diary" entry (file+datetree "~/git-working/Writeups/org/diary.org")
	  "* %?\n%U\n" :clock-in t :clock-resume t)
	 ("p" "Paper" entry (file "~/git-working/Writeups/org/papers.org")
	  "* %?\n:PAPER: %U\n** Overview: \n\n** Abbreviations: \n\n** Useful Additional References: \n\n")
	 ("i" "Idea" entry (file org-default-notes-file)
	  "* %? :IDEA: \n%t" :clock-in t :clock-resume t)
	 ("n" "Next Task" entry (file+headline org-default-notes-file "Tasks")
	  "** TODO NEXT %? \nDEADLINE: %t")
	 ("r" "TREE" entry (file org-default-notes-file)
	  "* %? \n\n")))

(setq org-tag-persistent-alist
      '(("MEETING" . ?m)
	("IDEA" . ?i)
	("DIARY" . ?d)
	("NEXT" . ?n)
	("PROJECT" . ?p)
	("BOOK" . ?b) ;; Use this for marking books in papers.org.
	("ADVANCED" .?a)
	("TEACHING" . ?t)
	("WRITEUP" . ?w)))

(setq org-latex-pdf-process
      '("pdflatex -interaction nonstopmode -output-directory %o %f"
	"bibtex %b"
	"pdflatex -interaction nonstopmode -output-directory %o %f"
	"pdflatex -interaction nonstopmode -output-directory %o %f"))

(setq org-ref-default-bibliography "~/git-working/WriteUps/references_all.bib")

;;Looks at top level directory and recursively adds .org files it finds.
(defvar org-agenda-regx 0 "Regular expression for org files.")
(setq org-agenda-regx "\\`[^.].*\\.org\\'")
(defun load-agenda-recursively (dir) "Find All Directories in DIR."
       (unless (file-directory-p dir) (error "Not a directory %s" dir))
       (unless (equal (directory-files dir nil org-agenda-regx t) nil)
	 (add-to-list 'org-agenda-files dir)
       )
       (dolist (file (directory-files dir nil nil t))
	 (unless (member file '("." ".."))
	   (let ((file (concat dir file "/")))
	     (when (file-directory-p file)
	       (load-agenda-recursively file)
	     )
	   )
	 )
       )
)
(load-agenda-recursively (file-truename "~/git-working/WriteUps/"))
(global-set-key (kbd "C-c w") 'org-refile)


;;--------------------
;;; Mailing People

(setq read-mail-command 'gnus)

;;-------------------------------------------------------------
;;;    Myriad of Syntax Highlighting/Checking/Completion
;;-------------------------------------------------------------

;; --- Magit Config

(global-set-key (kbd "C-c m") 'magit-status)

;; -- YCMD Setup
(require 'ycmd)
(setq ycmd-server-command
      (list "python3" "-u" (file-truename "~/.emacs.d/ycmd/ycmd/")))
(setq ycmd-global-config (file-truename "~/.emacs.d/ycmd/cpp/ycm/.ycm_extra_conf.py"))
(add-hook 'ycmd-mode-hook 'company-ycmd-setup)
;;(add-hook 'ycmd-mode-hook 'flycheck-ycmd-setup)

(global-company-mode t)
;;(global-ycmd-mode t)
;;(add-hook 'after-init-hook #'global-ycmd-mode)


;; -- Enable Flycheck on Everything.

(global-flycheck-mode t)

;; --- Setup CUDA

(setq gud-gdb-command-name "cuda-gdb --annotate=3")


; --- Helm Config

(require 'helm)
(require 'helm-config)
(require 'helm-files)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-c g") 'helm-google-suggest) ;; Man vs Google, I'm a millenial, so google it!
;;(global-set-key (kbd "C-x b") 'switch-to-buffer)
(global-set-key (kbd "C-x B") 'helm-mini)
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(when (executable-find "curl")
  (setq helm-net-prefer-curl t))

(setq helm-split-window-inside-p           t ; open helm buffer inside current window, not occupy whole other window
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

;; - Jupyter Notebook

(require 'ein-jupyter)
(setq ein:jupyter-default-server-command "jupyter notebook")
(setq ein:jupyter-default-notebook-directory (file-truename "~/git-working/"))


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
    ("~/git-working/WriteUps/Closure/closures.org" "~/git-working/WriteUps/ARM_SVE/arm_sve.org" "/Users/jameskent/git-working/WriteUps/W-Towers/wtowers.org" "/Users/jameskent/git-working/WriteUps/PhD-Thesis/thesis.org" "/Users/jameskent/git-working/WriteUps/org/capture.org" "/Users/jameskent/git-working/WriteUps/org/diary.org" "/Users/jameskent/git-working/WriteUps/org/notes.org" "/Users/jameskent/git-working/WriteUps/org/papers.org" "/Users/jameskent/git-working/WriteUps/org/todo.org")))
 '(package-selected-packages
   (quote
    (haskell-mode ein rust-mode flycheck-ycmd company-ycmd ycmd flycheck auctex xpm keychain-environment markdown-mode markdown-mode+ company-c-headers company-irony-c-headers company-irony typescript-mode irony ac-c-headers google-this auto-complete-c-headers auto-complete-auctex helm list-packages-ext cuda-mode ox-pandoc pandoc pandoc-mode babel company twilight-anti-bright-theme eyebrowse neotree projectile auto-complete magit color-theme-sanityinc-tomorrow ## solarized-theme auctex-lua exec-path-from-shell auctex-latexmk cdlatex elscreen-multi-term elscreen-persist elscreen-separate-buffer-list git gitter gnuplot latex-extra latex-math-preview latex-unicode-math-mode org-random-todo org-readme org-ref)))
 '(send-mail-function (quote smtpmail-send-it)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(put 'narrow-to-page 'disabled nil)
