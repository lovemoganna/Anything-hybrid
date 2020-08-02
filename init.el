;; _*_ coding: utf-8;lexical-binding: t; _*_

;;; load initial setting file 
;; https://stackoverflow.com/questions/7252793/importing-files-in-emacs-lisp-emacs-configuration-file-in-the-same-directoyr
;; (load-file "~/.emacs.d/lisp/init-package")

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; (package-initialize)

(require 'ob-tangle)
(org-babel-load-file "~/.emacs.d/lisp/init-package.org")
