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
(require 'org-notmuch)
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

(provide 'config-org)
