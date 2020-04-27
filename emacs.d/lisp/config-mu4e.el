(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu/mu4e")
(require 'mu4e)


(define-key global-map "\C-xt" 'mu4e-headers-search)

(defun offlineimap-quick ()
  "Start OfflineIMAP."
  (interactive)
  (let* ((buffer (offlineimap-make-buffer)))
    (unless (get-buffer-process buffer)
      (let ((process (start-process-shell-command
                      "offlineimap quick"
                      buffer
                      offlineimap-command)))
        (set-process-filter process 'offlineimap-process-filter)
        (set-process-sentinel process 'offlineimap-process-sentinel))))
  (add-to-list 'global-mode-string '(:eval (offlineimap-mode-line)) t))



;; these are actually the defaults
(setq
  mu4e-maildir       "~/mail"   ;; top-level Maildir
  mu4e-sent-folder   "/sent"       ;; folder for sent messages
  mu4e-drafts-folder "/gmail/[Gmail].Drafts"     ;; unfinished messages
  mu4e-trash-folder  "/gmail/Trash"      ;; trashed messages
  mu4e-refile-folder "/[Gmail].All Mail")   ;; saved messages

(setq mu4e-headers-date-format "%d/%m/%y") ;; FFS america..
(setq mu4e-headers-include-related nil)
(setq mu4e-attachment-dir (file-truename "~/Downloads"))
(setq mu4e-contexts
    `( ,(make-mu4e-context
	  :name "Gmail"
	  :enter-func (lambda () (mu4e-message "Entering Gmail context"))
          :leave-func (lambda () (mu4e-message "Leaving Gmail context"))
	  :match-func (lambda (msg)
			(when msg 
			  (mu4e-message-contact-field-matches msg 
			    :to "jameschristopherkent@gmail.com")))
	  :vars '( ( user-mail-address	    . "jameschristopherkent@gmail.com" )
		   ( user-full-name	    . "James Kent" )
		   ( mu4e-inbox-folder      . "/gmail/INBOX" )
		   ( mu4e-sent-folder       . "/gmail/[Gmail].Sent Mail" )
		   ( mu4e-trash-folder      . "/gmail/[Gmail].Trash" )
		   ( mu4e-drafts-folder     . "/gmail/[Gmail].Drafts" )
		   ( mu4e-refile-folder     . "/gmail/[Gmail].All Mail" )
		   ( mu4e-compose-signature .
		     (concat
		      "James\n"))
		   (mu4e-maildir-shortcuts . ( ("/gmail/INBOX" . ?i)
					       ("/gmail/[Gmail].Sent Mail" . ?s)
					       ("/gmail/[Gmail].Trash" . ?t)
					       ("/gmail/[Gmail].Drafts"   . ?d)
					       ("/gmail/[Gmail].All Mail" . ?a)
					       ))))
       ,(make-mu4e-context
	  :name "Cambridge"
	  :enter-func (lambda () (mu4e-message "Entering Cambridge context"))
	  :leave-func (lambda () (mu4e-message "Leaving Cambridge context"))
	  :match-func (lambda (msg)
			(when msg 
			  (mu4e-message-contact-field-matches msg 
			    :to "jck42@cam.ac.uk")))

	  :vars '( ( user-mail-address	     . "jck42@cam.ac.uk" )
		   ( user-full-name	     . "James Kent" )
		   ( mu4e-inbox-folder      . "/hermes/INBOX" )
		   ( mu4e-sent-folder       . "/hermes/Sent Messages" )
		   ( mu4e-trash-folder      . "/hermes/Trash" )
		   ( mu4e-drafts-folder     . "/hermes/drafts" )
		   ( mu4e-refile-folder     . "/hermes/Archive" )
		   ( mu4e-compose-signature  .
		     (concat
		       "James Kent\n"
		       "Cavendish Laboratory\n"))
		   (mu4e-maildir-shortcuts . ( ("/hermes/INBOX" . ?i)
					       ("/hermes/Sent Messages" . ?s)
					       ("/hermes/Trash" . ?t)
					       ("/hermes/drafts"   . ?d)
					       ("/hermes/Archive" . ?a)
					       ))))))

  ;; set `mu4e-context-policy` and `mu4e-compose-policy` to tweak when mu4e should
  ;; guess or ask the correct context, e.g.

  ;; start with the first (default) context; 
  ;; default is to ask-if-none (ask when there's no context yet, and none match)
  ;; (setq mu4e-context-policy 'pick-first)

  ;; compose with the current context is no context matches;
  ;; default is to ask 
  ;; (setq mu4e-compose-context-policy nil)



(provide 'config-mu4e)
