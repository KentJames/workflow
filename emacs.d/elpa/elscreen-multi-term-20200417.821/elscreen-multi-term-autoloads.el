;;; elscreen-multi-term-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "elscreen-multi-term" "elscreen-multi-term.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from elscreen-multi-term.el

(autoload 'emt-multi-term "elscreen-multi-term" "\
NUMBERに対応するTERMに切り替える.なければ作成する.

\(fn &optional NUMBER)" t nil)

(autoload 'emt-toggle-multi-term "elscreen-multi-term" "\
NUMBERに対応するTERMと現在のBUFFERを切り替える.

\(fn &optional NUMBER)" t nil)

(autoload 'emt-pop-multi-term "elscreen-multi-term" "\
NUMBERに対応するTERMをPOPさせる.

\(fn &optional NUMBER)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "elscreen-multi-term" '("emt-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; elscreen-multi-term-autoloads.el ends here
