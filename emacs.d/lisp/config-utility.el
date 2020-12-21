;; This contains elisp utility functions I find useful.

(defun get-size (file-or-dir)
  (let ((stat (file-attributes file-or-dir 'string)))
    ;; Get Size in Bytes
    (nth 7 stat)))

(defun find-directory-size (dir-name)

  (interactive "DDirectory: ")
  ;; Recursively get all sub-directories. Don't follow symlinks.
  (let ((sub-dirs (directory-files-recursively dir-name "" t)))
    (message ; Print message to minibuffer.
     (number-to-string
      ;; Get size of all files and directorys.
      ;; Then reduce over the sequence to find total.
      (reduce '+ (mapcar 'get-size sub-dirs))))))

(provide 'config-utility)
