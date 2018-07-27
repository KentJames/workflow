;;; Setup Mail Settings:

(setq user-mail-address "jck42@cam.ac.uk"
      mail-host-address "cam.ac.uk"
      user-full-name "James Kent"
      my-imap-server "imap.hermes.cam.ac.uk"
      my-smtp-server "smtp.hermes.cam.ac.uk")

(setq gnus-select-method
      '(nnimap "cam"
	       (nnimap-address "imap.hermes.cam.ac.uk")
	       (nnimap-server-port 993)
	       (nnimap-stream ssl)))

(setq smtpmail-smtp-server "smtp.hermes.cam.ac.uk"
      smtpmail-smtp-service 587
      gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]")

(setq gnus-secondary-select-methods '((nnml "")))

(add-to-list 'gnus-secondary-select-methods
	     '(nnimap "gmail"
		      (nnimap-address "imap.gmail.com")
		      (nnimap-server-port 993)
		      (nnimap-stream ssl)
		      (nnir-search-engine imap)))

;;; Make it all look useable

(setq gnus-article-date-headers '(user-defined)
        gnus-article-time-format
        (lambda (time)
          (let* ((date (format-time-string "%a, %d %b %Y %T %z" time))
                 (local (article-make-date-line date 'local))
                 (combined-lapsed (article-make-date-line date
                                                          'combined-lapsed))
                 (lapsed (progn
                           (string-match " (.+" combined-lapsed)
                           (match-string 0 combined-lapsed))))
            (concat local lapsed))))

(setq gnus-summary-thread-gathering-function 'gnus-gather-threads-by-subject)

