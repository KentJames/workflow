;;; Mailing People

(setq user-mail-address "jck42@cam.ac.uk")

(setq send-mail-function 'sendmail-send-it
       sendmail-program "/usr/local/bin/msmtp"
       mail-specify-envelope-from t
       message-sendmail-envelope-from 'header
       mail-envelope-from 'header)

(provide 'config-msmtp)
