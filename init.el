;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

(require 'org-install)

(require 'ob-tangle)
;;; Code:
(org-babel-load-file (expand-file-name "my-config.org" user-emacs-directory))

(put 'downcase-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("a2cde79e4cc8dc9a03e7d9a42fabf8928720d420034b66aecc5b665bbf05d4e9" default)))
 '(evil-auto-indent t)
 '(evil-mode t)
 '(ido-mode (quote both) nil (ido))
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(nyan-wavy-trail t)
 '(org-html-htmlize-output-type (quote css))
 '(package-selected-packages
   (quote
    (py-autopep8 elpy format-all python-info python-mode org-preview-html org-babel-eval-in-repl helm-flyspell helm-ispell auto-dictionary yasnippet-snippets yasnippet flycheck eval-in-repl company hungry-delete swiper counsel smartparens js2-mode web-mode helm helm-projectile helm-descbinds nodejs-repl exec-path-from-shell monokai-theme doom-themes doom-modeline evil evil-collection ace-jump-mode nyan-mode paradox youdao-dictionary use-package)))
 '(tramp-mode nil nil (tramp))
 '(winner-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
