;; Emacs package source
(require 'package)

;;; slove contract melpa.gnu.org:443 question

;; https://www.reddit.com/r/emacs/comments/cdei4p/failed_to_download_gnu_archive_bad_request/etw48ux
;; https://stackoverflow.com/questions/29085937/package-refresh-contents-hangs-at-contacting-host-elpa-gnu-org80
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")

			 ("marmalade" . "http://marmalade-repo.org/packages/")
			 ("melpa" . "http://melpa.org/packages/")))

;;; China Tuna Package Source
;; (setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
;; 			   ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))

(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
		    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl (warn "\
  Your version of Emacs does not support SSL connections,
  which is unsafe because it allows man-in-the-middle attacks.
  There are two things you can do about this warning:
  1. Install an Emacs version that does support SSL and be safe.
  2. Remove this warning from your init file so you won't see it again."))
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
  ;; and `package-pinned-packages`. Most users will not need or want to do this.
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  )

;; Add packages
(defvar revolt/package-list
      '(
	smartparens
	better-defaults
	pkg-info
	epl
	doom-themes
	doom-modeline
	js2-mode
	js2-refactor
	xref-js2
	mermaid-mode
	helm
	helm-projectile
	helm-ag
	helm-flyspell
	flycheck
	helm-flycheck
	;;ob-mermaid
	f
	dash
	youdao-dictionary
	names
	chinese-word-at-point
	pos-tip
	yasnippet
	yasnippet-snippets
	aggressive-indent
	wolfram
	slime
	quelpa
	;;pdf-tools
	ox-hugo
	web-mode
	web-beautify
	emmet-mode
	org-bullets
	ob-http
	monokai-theme
	helm-circe
	evil
	evil-leader
	which-key
	general
	window-numbering
	stumpwm-mode
	company
	company-web
	neotree
	htmlize
	real-auto-save
	markdown-mode
	edit-indirect
	polymode
	mmm-mode
	poly-R
	poly-markdown
	ess
	python-mode
	org-download
	pdf-tools
	org-noter
	engine-mode
	pyim
	org-roam
	org-roam-server
	w3m
	command-log-mode
	posframe
	sdcv
	expand-region
	flymake-go
	))
(setq package-selected-packages revolt/package-list)

(require 'cl)
(defun revolt/packages-installed-p()
  (loop for pkg in revolt/package-list
	when (not (package-installed-p pkg))
	do (return nil)
	finally (return t)
	))

(unless (revolt/packages-installed-p)
  (message "%s" "searching you lost package.....")
  (package-refresh-contents)
  (message "%s" "refersh successed melpa library!")
  (dolist (pkg revolt/package-list)
    (when (not (package-installed-p pkg))
      (package-install pkg))))

;; load another setting path
(add-to-list 'load-path "~/.emacs.d/lisp")

;; use quelpa manage pacakge
(unless (package-installed-p 'quelpa)
  (with-temp-buffer
    (url-insert-file-contents "https://github.com/quelpa/quelpa/raw/master/quelpa.el")
    (eval-buffer)
    (quelpa-self-upgrade)))

;; another pacakge manage tools -- quelpa
;; (require 'init-quelpa "./quelpa/init-quelpa")

(package-initialize) ;; You might already have this line

;; org setting
(require 'init-org "./org/init-org")

;; customize
(require 'ob-tangle)
(org-babel-load-file "~/.emacs.d/lisp/customize/customize.org")

					;(setq custom-file "~/.emacs.d/lisp/customize/customize.el")
					;(if (file-exists-p custom-file)
					;    (load-file custom-file))

;; utils settings
(require 'init-utils "./utils/init-utils")

;; package manage tools
;;(require 'init-cask "./cask/init-cask")


;; import test module
;;(require 'init-test "./test/init-test")

;; customize keyboard macro
(fset 'helloa
      (kmacro-lambda-form [?\( ?m ?e ?s ?s ?a ?g ?e ?  ?\" ?h ?e ?l ?l ?o ?\" ?\)] 0 "%d"))

;; my-command-line macro
(fset 'my-comment-line
      (kmacro-lambda-form [?» ?\C-u ?5 ?0 ?-] 0 "%d"))

;; convenient
(defalias 'rs 'replace-string)
