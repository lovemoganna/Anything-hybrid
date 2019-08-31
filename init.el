;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

(require 'org-install)

(require 'ob-tangle)

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
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(org-agenda-files
   (quote
    ("~/.emacs.d/test/demo.org" "/home/revolt/org/a.org")))
 '(package-selected-packages
   (quote
    (ace-jump-mode yasnippet-classic-snippets evil-collection youdao-dictionary yasnippet paradox spaceline-all-the-icons helm-descbinds helm-projectile wgrep nyan-mode el-get evil doom-modeline doom-themes company))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
