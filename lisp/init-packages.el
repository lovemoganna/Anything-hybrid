(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
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
		;; --- Minor Mode ---
		nodejs-repl
		exec-path-from-shell
		;; --- Themes ---
		monokai-theme
		;; solarized-theme
		) "Default packages")

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

;; Find Executable Path on OS X
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))


;; 暴露出去
(provide 'init-packages)