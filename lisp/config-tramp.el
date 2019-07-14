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

(provide 'config-tramp)
