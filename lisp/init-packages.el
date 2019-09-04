;;; init-packages.el --- emacs init pacakge:
;;; Commentary:
;;; Code:

(when (>= emacs-major-version 24)
  (package-initialize)
  (require 'package)
  (setq package-archives '(("gnu" ."http://elpa.emacs-china.org/gnu/")
			   ("melpa" . "http://elpa.emacs-china.org/melpa/")
			   ))
  )

;; cl - Common Lisp Extension
(require 'cl)

 ;; Add Packages
(defvar revolt/packages '(
		;; --- Auto-completion ---
		company
		;; --- Better Editor ---
		hungry-delete
		swiper
		counsel
		smartparens
		;; --- Major Mode ---
		js2-mode
		web-mode
		helm
		helm-projectile
		helm-descbinds
        python
		;;python-info
		;; --- Minor Mode ---
		nodejs-repl
		exec-path-from-shell
		;; --- Themes ---
		monokai-theme
		doom-themes
		doom-modeline
		;; --- Evil Mode ---
		evil
		evil-collection
		;; --- ace jump ---
		ace-jump-mode
		nyan-mode
		;; --- package manage---
		paradox
		;; --- dictionary ---
		youdao-dictionary
		;; --- use-package ---
		use-package
		;; --- yasnippet
		yasnippet
		yasnippet-snippets
		;; --- flycheck ---
		flycheck
		auto-dictionary
		;; --- eval-in-repl ---
		eval-in-repl
		org-babel-eval-in-repl
		) "Default packages.")

;; try to use `use-package'
(eval-when-compile
  (require 'use-package))


;; config emacs package source
(setq package-selected-packages revolt/packages)

(defun revolt/packages-installed-p ()
     (loop for pkg in revolt/packages
	   when (not (package-installed-p pkg)) do (return nil)
	   finally (return t)))

(unless (revolt/packages-installed-p)
     (message "%s" "Refreshing package database...")
     (package-refresh-contents)
     (dolist (pkg revolt/packages)
       (when (not (package-installed-p pkg))
	 (package-install pkg))))

;;; init-packages.el ends here
(provide 'init-packages)
