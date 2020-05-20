;;-*-emacs-lisp-*-
;; (text-scale-increase 2)
;; (text-scale-decrease 2)
;; (text-scale-adjust 0)

;; (add-to-list 'default-frame-alist '(font . "Iosevka SS02 10"))

;; use 'describe-char' find current font used
;; not luck,is error.

;; set default font in initial window and for any new window
 (cond
  ((string-equal system-type "gnu/linux")
   (when (member "Iosevka SS02" (font-family-list))
     (add-to-list 'initial-frame-alist '(font . "Iosevka fixed SS02-10"))
     (add-to-list 'default-frame-alist '(font . "Iosevka fixed SS14-10")))))

;; set font all windows. don't keep window size fixed
;; (set-frame-font "Iosevka Fixed SS14" nil t)
;; you must set the `pixelsize` the font will show beautiful!
(set-frame-font "Hack-9:style=Regular:antialias=True:pixelsize=12" nil t)


;; Chinese Font -- 中文字体的话，必须设置为 14px，才能使Org Mode里面的Table对齐。很是Fuck。
;; ref link: https://emacs-china.org/t/org-mode/440/52
;; https://emacs-china.org/t/org-mode-9-3/11217/12
    
;; slove tty font does not exit problem: https://lists.gnu.org/archive/html/emacs-devel/2006-12/msg00285.html

(if (display-graphic-p)
    (dolist (charset '(kana han symbol cjk-misc bopomofo))
      (set-fontset-font (frame-parameter nil 'font)
			charset (font-spec :family "WenQuanYi Zen Hei"
                                           :size 13)))) ;理解万岁

(require 'org-faces)
(set-face-attribute 'org-table nil :family "WenQuanYi Zen Hei")

(provide 'init-font)


