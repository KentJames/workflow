;;Theme

(require 'doom-themes)
(require 'doom-modeline)

;; Enable extra icons
(require 'all-the-icons)
;; Switch to -1 if you want to disable the scroll bar.
(scroll-bar-mode 0)

;; Enable Doom Modeline
(doom-modeline-mode 1)
(load-theme `doom-vibrant t)
(tool-bar-mode -1)

;; Enable flashing mode-line on errors
(doom-themes-visual-bell-config)

;; Corrects (and improves) org-mode's native fontification.
(doom-themes-org-config)


;;(setq initial-buffer-choice 5)

(defun desaturate-color (color-hex)
  "Converts a color string to its desaturated equivalent hex string"
  (require 'color)
  (apply
   'color-rgb-to-hex
   (append (apply
            'color-hsl-to-rgb
            (apply
             'color-desaturate-hsl
             `(,@(apply 'color-rgb-to-hsl (color-name-to-rgb color-hex)) 50)))
           '(2))))

(defun transform-theme-colors (fn)
  "Apply FN to the colors on every active face.

   FN should accept the face symbol and the current color,
   and return the new color to be applied."
  (interactive)
  (mapc
   (lambda (face)
     (mapc
      (lambda (attr)
        (let ((current (face-attribute face attr)))
          (unless (or (not current)
                      (listp current)
                      (string= current "unspecified")
                      (string= current "t"))
            (set-face-attribute face nil attr (funcall fn face current)))))
      '(:foreground :background :underline :overline :box :strike-through
                    :distant-foreground))
     (mapc
      (lambda (complex-attr)
        (let* ((full (copy-tree (face-attribute face complex-attr)))
               (current (if (listp full) (member :color full))))
          (unless (or (not current)
                      (not (listp full)))
            (setcar (cdr current) (funcall fn face (cadr current)))
            (set-face-attribute face nil complex-attr full))))
      '(:underline :overline :box)))
   (face-list)))

(defun desaturate-theme ()
  "As title: desaturate all currently active face colorsj."
  (interactive)
  (transform-theme-colors
   (lambda (face color)
     (desaturate-color color))))

(provide 'config-theme)



