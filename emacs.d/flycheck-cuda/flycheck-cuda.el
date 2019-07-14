;; This buffer is for text that is not saved, and for Lisp evaluation.
;; To create a file, visit it with <open> and enter text in its buffer.

(require 'flycheck)

;;(setq exec-path (append exec-path '("/usr/local/cuda/bin"))) ; Our cuda path

(flycheck-def-args-var flycheck-cuda-args cuda
  :package-version '(flycheck . "0.01"))

(flycheck-def-option-var flycheck-cuda-language-standard nil cuda
  "Our CUDA Language Standard "
  :type '(choice (const :tag "Default standard" nil)
		 (string :tag "Language standard"))
  :safe #'stringp
  :package-version '(flycheck . "0.32"))
(make-variable-buffer-local 'flycheck-cuda-language-standard)

(flycheck-def-option-var flycheck-cuda-includes nil cuda
  "Our include directories to pass to nvcc "
  :type '(repeat (file :tag "Include file"))
  :safe #'flycheck-string-list-p
  :package-version '(flycheck . "0.32"))

(flycheck-def-option-var flycheck-cuda-definitions nil cuda
  "Additional preprocessor definitions for nvcc.
A list of strings to pass to cuda, a la flycheck-clang"
  :type '(repeat (string :tag "Definitions"))
  :safe #'flycheck-string-list-p
  :package-version '(flycheck . "0.32"))

(flycheck-def-option-var flycheck-cuda-include-path nil cuda
  "A list of include directories for nvcc."
  :type '(repeat (directory :tag "Include directory"))
  :safe #'flycheck-string-list-p
  :package-version '(flycheck . "0.32"))

(flycheck-define-checker cuda
  "A CUDA C/C++ syntax checker using nvcc.

See URL `https://developer.nvidia.com/cuda-llvm-compiler'."
  :command ("nvcc"
            "-c" ;; Compile Only
            (option "-std=" flycheck-cuda-language-standard concat)
            (option-list "-include" flycheck-cuda-includes)
            (option-list "-D" flycheck-cuda-definitions concat)
            (option-list "-I" flycheck-cuda-include-path)
            ;; Read from standard input
            source)
  :error-patterns
  ((error line-start
          (message "In file included from") " " (or "<stdin>" (file-name))
          ":" line ":" line-end)
   (error line-start (or "<stdin>" (file-name)) "(" line "): error: " (message) line-end)
   (error line-start (or "<stdin>" (file-name)) ":" line ":" column
         ": fatal error: " (optional (message)) line-end)
   (warning line-start (or "<stdin>" (file-name)) "(" line "): warning: " (message) line-end))
  :modes cuda-mode)
