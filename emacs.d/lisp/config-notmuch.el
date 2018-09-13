;;; Mailing People

(setq user-mail-address "jck42@cam.ac.uk")





 (setq send-mail-function 'sendmail-send-it
       sendmail-program "/usr/local/bin/msmtp"
       mail-specify-envelope-from t
       message-sendmail-envelope-from 'header
       mail-envelope-from 'header)


;; Notmuch Configuration

(require 'notmuch)
(autoload 'notmuch "notmuch" "notmuch mail" t)
(add-to-list 'notmuch-tagging-keys '("c" ("+collaborator") "Collaborator"))
(add-to-list 'notmuch-tagging-keys '("b" ("+bojan") "Bojan"))

(defun notmuch-permadelete-elisp ()
  (interactive)
  (mapc 'delete-file
    (split-string
     (shell-command-to-string "notmuch search --output=files tag:deleted") "[\n]+")))



(provide 'config-notmuch)
