;;; cuda-mode-autloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads nil "cuda-mode" "cuda-mode.el" (23465 25964 245172
;;;;;;  304000))
;;; Generated autoloads from cuda-mode.el

(easy-menu-define cuda-menu cuda-mode-map "CUDA Mode Commands" (cons "CUDA" (c-lang-const c-mode-menu cuda)))

(autoload 'cuda-mode "cuda-mode" "\
Major mode for editing CUDA.
Cuda is a C like language extension for mixed native/GPU coding
created by NVIDIA

The hook `c-mode-common-hook' is run with no args at mode
initialization, then `cuda-mode-hook'.

Key bindings:
\\{cuda-mode-map}

\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "cuda-mode" '(#("cuda-" 0 5 (face font-lock-variable-name-face fontified t)))))

;;;***

(provide 'cuda-mode-autloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; cuda-mode-autloads.el ends here
