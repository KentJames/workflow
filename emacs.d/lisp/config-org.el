;;-------------------------------------------------------------
;;; Documentation and Org-Mode Settings
;;--------------------------------------------------------------


;;Fix Latex-Mode
(add-hook 'doc-view-mode-hook 'auto-revert-mode)
(set-variable 'doc-view-continuous t)

;; Org Mode Settings

(require 'org)
(require 'org-ref)
(require 'org-capture)
(require 'org-mu4e)
(require 'org-pdfview)

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-directory "~/git-working/WriteUps/org")
(setq org-default-notes-file (concat org-directory "/capture.org"))
;;(setq org-archive-location (concat org-directory "/%s_archive::"))
(define-key global-map "\C-cc" 'org-capture)
(setq org-log-done t)
(setq org-startup-indented t)
(setq org-pretty-entities nil)
(setq org-pretty-entities-include-sub-superscripts nil)
(setq org-todo-keywords '((sequence "TODO" "INPROGRESS" "|" "DONE" "CANCELLED")
			  ))

(setq org-refile-targets '((nil :maxlevel . 2)
                                (org-agenda-files :maxlevel . 2)))
(setq org-outline-path-complete-in-steps nil)         ; Refile in a single go
(setq org-refile-use-outline-path t)                  ; Show full paths for refiling

(defun refile-in-current ()
"refile current item in current buffer"
(interactive)
(let ((org-refile-use-outline-path t)
    (org-refile-targets '((nil . (:maxlevel . 5)))))
  (org-refile)))

;;Add Graphviz to org mode
(add-to-list 'org-src-lang-modes (quote ("dot" . graphviz-dot)))

;; Org Capture Templates / Tags


(setq org-capture-templates
       '(("t" "TODO" entry (file org-default-notes-file)
	  "* TODO %?\n%u\n%a\n" :clock-in t :clock-resume t)
	 ("m" "Meeting" entry (file+datetree "~/git-working/WriteUps/org/diary.org")
	  "* MEETING with %? :MEETING:\n%t" :clock-in t :clock-resume t)
	 ("d" "Diary" entry (file+datetree "~/git-working/Writeups/org/diary.org")
	  "* %?\n%u\n%a\n" :clock-in t :clock-resume t)
	 ("p" "Paper" entry (file "~/git-working/Writeups/org/papers.org")
	  "* %?\n:PAPER: %U\n** Overview: \n\n** Abbreviations: \n\n** Useful Additional References: \n\n")
	 
	 ("i" "Idea" entry (file org-default-notes-file)
	  "* %? :IDEA: \n%t" :clock-in t :clock-resume t)
	 ("n" "Note" entry (file org-default-notes-file)
	  "")
	 ("r" "TREE" entry (file org-default-notes-file)
	  "* %? \n\n")))

(setq org-tag-persistent-alist
      '(("MEETING" . ?m)
	("IDEA" . ?i)
	("DIARY" . ?d)
	("NEXT" . ?n)
	("PROJECT" . ?p)
	("PROJECT(PERSONAL)" . ?o)
	("BOOK" . ?b) ;; Use this for marking books in papers.org.
	("ADVANCED" .?a)
	("TEACHING" . ?t)
	("WRITEUP" . ?w)))

(setq org-latex-pdf-process
      '("pdflatex -interaction nonstopmode -output-directory %o %f"
	"bibtex %b"
	"pdflatex -interaction nonstopmode -output-directory %o %f"
	"pdflatex -interaction nonstopmode -output-directory %o %f"))

;; Setup Org Code Execution Blocks

(setq org-babel-load-languages '(("emacs-lisp" . t) ("python" . t)))


;; Open pdf links in pdf-view mode

(add-to-list 'org-file-apps 
             '("\\.pdf\\'" . (lambda (file link)
                                     (org-pdfview-open link))))


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


;; My bibliography for references. 
(setq org-ref-default-bibliography "~/git-working/WriteUps/references_all.bib")
(setq reftex-default-bibliography '("~/git-working/WriteUps/references_all.bib"))
(setq reftex-plug-into-AUCTeX t)
;; see org-ref for use of these variables
(setq org-ref-bibliography-notes "~/git-working/WriteUps/org/notes.org"
      org-ref-default-bibliography '("~/git-working/WriteUps/references_all.bib")
      org-ref-pdf-directory "~/Google_Drive/PhD/Academic/Reading")

(global-set-key (kbd "C-c o") 'org-ref-helm-insert-cite-link)

(add-hook 'org-mode-hook (lambda ()
(progn
			   (local-set-key "\C-ce" 'refile-in-current)
			   (org-bullets-mode 1))))

'(org-agenda-files
  (quote
   ("/Users/jameskent/git-working/WriteUps/org/notes.org" "~/git-working/WriteUps/Closure/closures.org" "~/git-working/WriteUps/ARM_SVE/arm_sve.org" "/Users/jameskent/git-working/WriteUps/W-Towers/wtowers.org" "/Users/jameskent/git-working/WriteUps/PhD-Thesis/thesis.org" "/Users/jameskent/git-working/WriteUps/org/capture.org" "/Users/jameskent/git-working/WriteUps/org/diary.org" "/Users/jameskent/git-working/WriteUps/org/papers.org")))


;; Finally - Eye Candy
(setq org-bullets-bullet-list '("◉" "○"))


(provide 'config-org)
