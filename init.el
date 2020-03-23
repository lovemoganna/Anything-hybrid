;; _*_ coding: utf-8;lexical-binding: t; _*_
;; emacs settings plain gnu emacs only


;;; --------------------
;; initial window and default window

;; UTF-8 as default encoding
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8-unix)


;; hacks to reduce the startup time.
(setq gc-cons-threshold (expt 2 24))
(setq load-prefer-newer t)


;;; Location of various files
(defmacro re/file-accessors(name val)
  "Define variable and function for accessing my directories."
  (let ((dir-var (intern (concat "re/" name "-dir")))
	(file-fun (intern (concat "re/" name "-dir-file"))))
    `(progn
       (defvar ,dir-var ,val)
       (defun ,file-fun (file)
	 ,(format "Return full file name of a FILE placed in '%s'." dir-var)
	 (expand-file-name file ,dir-var)))
    ))


;; entrance
(buffer-file-name)

;; re/emacs-init-dir-file			
(re/file-accessors "emacs-init"
                   (file-name-directory
                    (file-truename (or load-file-name buffer-file-name))))
					
;; re/emacs-dir-file
(re/file-accessors "emacs"  (re/emacs-init-dir-file "../"))


;; Basic Configuration

;;; load initila setting file 
;; https://stackoverflow.com/questions/7252793/importing-files-in-emacs-lisp-emacs-configuration-file-in-the-same-directoyr
(load-file "~/.emacs.d/lisp/init-package")
(require 'init-package "./init-package")


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#282a36" "#ff5555" "#50fa7b" "#f1fa8c" "#61bfff" "#ff79c6" "#8be9fd" "#f8f8f2"])
 '(compilation-message-face 'default)
 '(custom-safe-themes
   '("774aa2e67af37a26625f8b8c86f4557edb0bac5426ae061991a7a1a4b1c7e375" "a2cde79e4cc8dc9a03e7d9a42fabf8928720d420034b66aecc5b665bbf05d4e9" "d71aabbbd692b54b6263bfe016607f93553ea214bc1435d17de98894a5c3a086" "a339f231e63aab2a17740e5b3965469e8c0b85eccdfb1f9dbd58a30bdad8562b" "e1ef2d5b8091f4953fe17b4ca3dd143d476c106e221d92ded38614266cea3c8b" "d5f8099d98174116cba9912fe2a0c3196a7cd405d12fa6b9375c55fc510988b5" "7f791f743870983b9bb90c8285e1e0ba1bf1ea6e9c9a02c60335899ba20f3c94" "be9645aaa8c11f76a10bcf36aaf83f54f4587ced1b9b679b55639c87404e2499" "777a3a89c0b7436e37f6fa8f350cbbff80bcc1255f0c16ab7c1e82041b06fccd" "1ed5c8b7478d505a358f578c00b58b430dde379b856fbcb60ed8d345fc95594e" "bc836bf29eab22d7e5b4c142d201bcce351806b7c1f94955ccafab8ce5b20208" default))
 '(erc-modules
   '(autoaway autojoin button completion fill irccontrols list log match menu move-to-prompt netsplit networks noncommands notify notifications readonly replace ring smiley sound stamp track))
 '(fci-rule-color "#6272a4")
 '(highlight-changes-colors '("#FD5FF0" "#AE81FF"))
 '(highlight-tail-colors
   '(("#3C3D37" . 0)
     ("#679A01" . 20)
     ("#4BBEAE" . 30)
     ("#1DB4D0" . 50)
     ("#9A8F21" . 60)
     ("#A75B00" . 70)
     ("#F309DF" . 85)
     ("#3C3D37" . 100)))
 '(jdee-db-active-breakpoint-face-colors (cons "#1E2029" "#bd93f9"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#1E2029" "#50fa7b"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#1E2029" "#565761"))
 '(magit-diff-use-overlays nil)
 '(objed-cursor-color "#ff5555")
 '(org-agenda-files
   '("~/.emacs.d/lisp/.Ktask/task_index.org" "~/.emacs.d/lisp/.Ktask/agenda_index.org"))
 '(org-confirm-babel-evaluate nil)
 '(org-hugo-auto-set-lastmod t)
 '(org-hugo-section "post")
 '(package-selected-packages
   '(ansi package-build shut-up epl git commander f dash s cask pdf-tools ob-mermaid mermaid-mode helm-slime slime evil-terminal-cursor-changer popwin youdao-dictionary yasnippet-snippets wolfram wolfram-mode helm-circe circe yasnippet company-shell doom-modeline projectile helm magit ox-hugo org-bullets evil monokai-theme company))
 '(pdf-view-midnight-colors (cons "#f8f8f2" "#282a36"))
 '(pos-tip-background-color "#FFFACE")
 '(pos-tip-foreground-color "#272822")
 '(rustic-ansi-faces
   ["#282a36" "#ff5555" "#50fa7b" "#f1fa8c" "#61bfff" "#ff79c6" "#8be9fd" "#f8f8f2"])
 '(vc-annotate-background "#282a36")
 '(vc-annotate-color-map
   (list
    (cons 20 "#50fa7b")
    (cons 40 "#85fa80")
    (cons 60 "#bbf986")
    (cons 80 "#f1fa8c")
    (cons 100 "#f5e381")
    (cons 120 "#face76")
    (cons 140 "#ffb86c")
    (cons 160 "#ffa38a")
    (cons 180 "#ff8ea8")
    (cons 200 "#ff79c6")
    (cons 220 "#ff6da0")
    (cons 240 "#ff617a")
    (cons 260 "#ff5555")
    (cons 280 "#d45558")
    (cons 300 "#aa565a")
    (cons 320 "#80565d")
    (cons 340 "#6272a4")
    (cons 360 "#6272a4")))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   '(unspecified "#272822" "#3C3D37" "#F70057" "#F92672" "#86C30D" "#A6E22E" "#BEB244" "#E6DB74" "#40CAE4" "#66D9EF" "#FB35EA" "#FD5FF0" "#74DBCD" "#A1EFE4" "#F8F8F2" "#F8F8F0")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
