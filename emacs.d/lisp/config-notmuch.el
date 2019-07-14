;;; Mailing People

(setq user-mail-address "jck42@cam.ac.uk")

(setq send-mail-function 'sendmail-send-it
       sendmail-program "/usr/local/bin/msmtp"
       mail-specify-envelope-from t
       message-sendmail-envelope-from 'header
       mail-envelope-from 'header)

;; Notmuch Configuration
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/")
(autoload 'notmuch "notmuch" "notmuch mail" t)
(require 'notmuch)
(add-to-list 'notmuch-tagging-keys '("c" ("+collaborator") "Collaborator"))
(add-to-list 'notmuch-tagging-keys '("b" ("+bojan") "Bojan"))

(defun notmuch-delete-directory (dirname)
     (shell-command (concat "rm -rf " dirname)))

(defun notmuch-permadelete-elisp ()
  (interactive)
  (mapc 'notmuch-delete-directory
    (split-string (shell-command-to-string "notmuch search --format=text0 --output=files tag:deleted") "[\0]+")))

(defun brew-service-check ()
  (interactive)
  (async-shell-command "brew services list"))

(defun brew-restart-offlineimap ()
  (interactive)
  (async-shell-command "brew restart offlineimap"))

(define-key global-map "\C-xt" 'notmuch-tree)

(custom-set-faces
 '(notmuch-message-summary-face ((t (:foreground "#3ff"))))
  '(notmuch-wash-cited-text ((t (:foreground "#f09fff")))))

(provide 'config-notmuch)


