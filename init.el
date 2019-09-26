;;; init.el ---  Rebuild Emacs Configure file:
;; $Id: revolt-rebuild-init.el,v 1.0 2019/09/06 20:30:18 Anti-RoteLearning

;; defconst --- constant variable
;; This declares the nither programs nor users should ever change the `revolt-init-version`.

(require 'org-install)
(require 'ob-tangle)
(org-babel-load-file (expand-file-name ".lisp/my-org-configuration.org" user-emacs-directory))

;; Default open line-numbers
;; (global-display-line-numbers-mode t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(before-save-hook
   (quote
    (copyright-update time-stamp revolt/backup-every-save)))
 '(cua-mode nil nil (cua-base))
 '(custom-safe-themes
   (quote
    ("fe666e5ac37c2dfcf80074e88b9252c71a22b6f5d2f566df9a7aa4f9bea55ef8" "3a3de615f80a0e8706208f0a71bbcc7cc3816988f971b6d237223b6731f91605" "f0dc4ddca147f3c7b1c7397141b888562a48d9888f1595d69572db73be99a024" "4697a2d4afca3f5ed4fdf5f715e36a6cac5c6154e105f3596b44a4874ae52c45" "b35a14c7d94c1f411890d45edfb9dc1bd61c5becd5c326790b51df6ebf60f402" "d2e9c7e31e574bf38f4b0fb927aaff20c1e5f92f72001102758005e53d77b8c9" "a3fa4abaf08cc169b61dea8f6df1bbe4123ec1d2afeb01c17e11fdc31fc66379" default)))
 '(display-time-24hr-format t)
 '(display-time-day-and-date t)
 '(display-time-format nil)
 '(display-time-mode t)
 '(fci-rule-color "#555556")
 '(jdee-db-active-breakpoint-face-colors (cons "#000000" "#fd971f"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#000000" "#b6e63e"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#000000" "#525254"))
 '(org-agenda-files
   (quote
    ("~/.emacs.d/.lisp/my-org-configuration.org" "~/org/org-mode" "~/org/org-mode_archive" "~/org/wangyin/programming" "~/org/GTD.org" "~/org/a.org")))
 '(org-src-tab-acts-natively t)
 '(package-selected-packages
   (quote
    (gnuplot-mode flycheck-plantuml emojify plantuml-mode graphviz-dot-mode helm-org adaptive-wrap projectile htmlize elpy org-bullets yasnippet undo-tree expand-region anzu whitespace-cleanup-mode shrink-whitespace doom-modeline doom-themes use-package company auto-complete swiper multiple-cursors smartparens easy-kill helm helm-descbinds youdao-dictionary aggressive-indent)))
 '(session-use-package t nil (session))
 '(vc-annotate-background "#1c1e1f")
 '(vc-annotate-color-map
   (list
    (cons 20 "#b6e63e")
    (cons 40 "#c4db4e")
    (cons 60 "#d3d15f")
    (cons 80 "#e2c770")
    (cons 100 "#ebb755")
    (cons 120 "#f3a73a")
    (cons 140 "#fd971f")
    (cons 160 "#fc723b")
    (cons 180 "#fb4d57")
    (cons 200 "#fb2874")
    (cons 220 "#f43461")
    (cons 240 "#ed404e")
    (cons 260 "#e74c3c")
    (cons 280 "#c14d41")
    (cons 300 "#9c4f48")
    (cons 320 "#77504e")
    (cons 340 "#555556")
    (cons 360 "#555556")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
