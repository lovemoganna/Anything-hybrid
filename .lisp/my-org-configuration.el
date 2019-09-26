(defconst revolt-init-version "$Id: revolt-rebuild-init.el,v 1.0 2019/09/06 20:30:18 Anti-RoteLearning$")

(require 'package)
;; unactive auto install package when emacs startup
(setq package-enable-at-startup nil)
;; Enable Melpa
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))
                        ;; ("melpa-stable" . "https://melpa-stable.milkbox.net/packages/")
(package-initialize)

;; Fix Emacs's unknown and untrusted anthirity TLS error
;; link: https://blog.vifortech.com/posts/emacs-tls-fix/
;; libressl link: http://ftp.openbsd.org/pub/OpenBSD/LibreSSL/

(require 'gnutls)
(add-to-list 'gnutls-trustfiles "/usr/loca/etc/ssl/cert.pem")

;; need common lisp replay
(require 'cl)
;; manage all installed packages
(defvar revolt/packages '(
                          ;; --- python support ---
                          elpy
                          ;; --- org mode support ---
                          org-bullets
                          ;; --- inhence your ability
                          yasnippet
                          undo-tree
                          ;; --- fast select text ---
                          expand-region
                          ;; --- better replace text ---
                          anzu
                          ;; --- clean all white space line ---
                          whitespace-cleanup-mode
                          ;; --- remove current cursor white space
                          shrink-whitespace
                          ;; --- Themes ---
                          doom-modeline
                          doom-themes
                          ;; --- manage package methods ---
                          use-package
                          ;; --- auto-completion ---
                          company
                          auto-complete
                          ;; --- better editor ---
                          swiper
                          multiple-cursors
                          smartparens
                          easy-kill
                          ;; --- helm-mode ---
                          helm
                          helm-descbinds
                          ;; --- youdao-dictionary ---
                          youdao-dictionary
                          ;; --- aggressive-indent ---
                          aggressive-indent
                          ;; --- use package ---
                          use-package
                          ;; --- literary programming ---
                          adaptive-wrap
                          ;; --- emacs emojj ---
                          emojify
                          ;; --- plantuml ---
                          plantuml-mode
                          ;; --- org mode ---
                          gnuplot
                          )"Default Packages")

(setq package-selected-packages revolt/packages)

;; datemine the packages state
(defun revolt/packages-installed-p ()
  (loop for pkg in revolt/packages
        when (not (package-installed-p pkg)) do (return nil)
        finally (return t)))

;; install package by package installed state
(unless (revolt/packages-installed-p)
     (message "%s" "Refreshing package melpa database...")
     (package-refresh-contents)
     (dolist (pkg revolt/packages)
       (when (not (package-installed-p pkg))
         (package-install pkg))))

;; use-package
;; manually.It will do automagic installation.delayed loading and things.
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; open init file
(defun revolt/open-my-init-file()
  "Open the user's init.el file"
  (interactive)
  (find-file (expand-file-name "~/.emacs.d/init.el")))

;; auto save often
;; save evary 20 characters typed(minium char numbers)
(setq auto-save-interval 16)

(setq
 backup-by-copying t     ; copy all files,don't rename them.
 kept-new-versions 10    ; keep 10 latest versions
 kept-old-versions 0     ; don't bother with old versions
 delete-old-versions t   ; don't ask to delete excess backup versions.
 version-control t       ; number backups
 vc-make-backup-files t) ; backup version controlled files

(defvar revolt/backup-file-size-limit (* 5 1024 1024)
  "Maximum size of a file (in bytes) that should be copied at each savepoint.")

;; base directory for backup files.
(defvar revolt/backup-location (expand-file-name "~/emacs-backups"))
;; unwanted backups directory
(defvar revolt/backup-trash-dir (expand-file-name "~/.Trash"))
;; don't backup when matching this regexp
;; files whose full name matches this regexp backup to `revolt/backup-trash-dir`
;; set to nil to disable this.
(defvar revolt/backup-exclude-regexp nil)

;; default per save backups directory
(setq backup-directory-alist
      `(("" . ,(expand-file-name "per-save" revolt/backup-location))))
;; trash dir
(if revolt/backup-exclude-regexp
    (add-to-list 'back-directory-alist `(,revolt/backup-exclude-regexp . ,revolt/backup-trash-dir)))

(defun revolt/backup-every-save()
  ;; make a special "per session" backup at the first save of each
  ;; emacs session
  (when (not buffer-backed-up)
    ;; overrid the default parameters for per-session backups.
    (let ((backup-directory-alist
           `(("." . ,(expand-file-name "per-session" revolt/backup-location))))
          (kept-new-versions 3))
      ;; add trash dir if needed
      (if revolt/backup-exclude-regexp
          (add-to-list
           'backup-directory-alist
           `(,revolt/backup-exclude-regexp . ,revolt/backup-trash-dir)))
      ;; the file too large
      (if (<= (buffer-size) revolt/backup-file-size-limit)
          (progn
            (message "Made per session backup of %s" (buffer-name))
            (backup-buffer))
        (message "WARING: File %s too large to backup -increase value of revolt/backup-file-size-limit" (buffer-name))))))

(add-hook 'before-save-hook 'revolt/backup-every-save)

(global-auto-revert-mode 1)

(use-package session
  :init
  (add-hook 'after-init-hook 'session-initialize))

(use-package recentf
  :config
  (progn
    ;; save every 10 minutes
    (run-at-time nil (* 10 60) 'recentf-save-list)
    ;; recentf file maxnumber set 1000
    (setq recentf-max-saved-items 1000
          recentf-auto-cleanup 'never
          recentf-exclude '("/ssh:"))
    (recentf-mode t)))

;; (use-package doom-themes
;;   :ensure t
;;   :config
;;   (load-theme 'doom-dracula t))
(setq doom-themes-enable-bold t
      doom-themes-enable-italic t) ; if nil, italics is universally disabled

;; Load the theme (doom-one, doom-molokai, etc); keep in mind that each theme
;; may have their own settings.
(load-theme 'doom-moonlight t)

;; Enable flashing mode-line on errors
(doom-themes-visual-bell-config)

;; Enable custom neotree theme (all-the-icons must be installed!)
(doom-themes-neotree-config)
;; or for treemacs users
(doom-themes-treemacs-config)

;; Corrects (and improves) org-mode's native fontification.
(doom-themes-org-config)

;; use doom-modeline
(require 'doom-modeline)
(doom-modeline-mode 1)

(global-hl-line-mode 1)

;;show line numbers
(global-linum-mode t)

;; Close Tool Bar
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
;;Close startup help screen
(setq inhibit-splash-screen 1)

;; Set Cursor Style
(setq-default cursor-type 'bar)

(setq inhibit-startup-message t)

(setq echo-keystrokes 0.5)

(use-package diminish
  ;; use-package make diminish mode load package from elpa
  ;; `ensure keywords` causes the packages to be installed automatically
  ;; if you wish this behavior to be glbal for all packages.you should set
  ;; (setq use-package-always-ensure t)

  ;; diminish keys,it's purpose is to remove minior mode string in your mode line.
  ;; demand keys,prevent defered loading in all cases.
  :ensure t
  :demand t
  :diminish abbrev-mode
  :diminish auto-fill-funcition)

(global-hl-line-mode +1)

(use-package whitespace
  :diminish whitespace-mode)

(setq whitespace-line-column 10000)

(use-package volatile-highlights
  :diminish volatile-highlights-mode
  :config
  (volatile-highlights-mode t))

(require 'youdao-dictionary)
(global-set-key (kbd "C-c y") 'youdao-dictionary-search-at-point)
(global-set-key (kbd "C-c v") 'youdao-dictionary-play-voice-at-point)
(global-set-key (kbd "C-c s") 'youdao-dictionary-search)

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t)         ;rename after kill uniquify buffer
(setq uniquify-ignore-buffers-re "^\\*")	;don't muck with special buffers

;; invocation name: program name,is `emacs`
  ;; (setq frame-title-format
  ;;  '("" invocation-name " - "
  ;;    (:eval (if (buffer-file-name)
  ;;               (abbreviate-file-name (buffer-file-name))
  ;;             "%b"))))
(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))
        (:eval (if (buffer-modified-p)
                   " •"))
        " - Emacs")
      )

;;  (use-package rainbow-mode)

(use-package rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(use-package page-break-lines
:diminish page-break-lines-mode
:config
  (global-page-break-lines-mode 1)
  (setq page-break-lines-modes '(emacs-lisp-mode lisp-mode scheme-mode compilation-mode outline-mode help-mode org-mode ess-mode latex-mode)))

(setq scroll-mavrgin 3)

(winner-mode t)

(add-hook 'after-init-hook #'global-emojify-mode)

;; active company mode
(add-hook 'after-init-hook 'global-company-mode)

;; immediately display advice
(setq company-idle-delay 0)
;; Show suggestions after entering one character.
(setq company-minimum-prefix-length 1)
(setq company-selection-wrap-around t)

;; Use tab key to cycle through suggestions.
;; ('tng' means 'tab and go')
(company-tng-configure-default)

(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'org-mode-hook 'turn-on-auto-fill)
(add-hook 'LaTeX-mode-hook 'turn-on-auto-fill)

(defun endless/fill-or-unfill ()
  "Like `fill-paragraph', but unfill if used twice."
  (interactive)
  (let ((fill-column
         (if (eq last-command 'endless/fill-or-unfill)
             (progn (setq this-command nil)
                    (point-max))
           fill-column)))
    (call-interactively #'fill-paragraph)))

(global-set-key [remap fill-paragraph]
                #'endless/fill-or-unfill)

(global-set-key (kbd "M-j")
                (lambda ()
                  (interactive)
                  (join-line -1)))

(require 'smartparens-config)
(add-hook 'js-mode-hook #'smartparens-mode)
(add-hook 'python-mode-hook #'smartparens-mode)
(add-hook 'emacs-lisp-mode-hook #'smartparens-mode)
;; by M-x sp-cheat-sheet

(use-package neotree
  :bind (("<f8>" . neotree-toggle)))

(add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)
(add-hook 'css-mode-hook #'aggressive-indent-mode)
(add-hook 'plantuml-mode-hook #'aggressive-indent-mode)
(add-hook 'python-mode-hook #'aggressive-indent-mode)



;; global active aggressive indent
(global-aggressive-indent-mode 1)



(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

(global-set-key (kbd "M-;") 'comment-dwim-2)

(use-package flyspell
  :diminish (flyspell-mode . "spell")
  :config
  (set-face-attribute 'flyspell-incorrect nil
                      :background "selectedKnobColor"
                      :underline '(:color "red")
                      :weight 'bold))

(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)
(setq ispell-dictionary "american")
(setq ispell-check-comments t)
(setq ispell-really-hunspell t)
(setq ispell-program-name "hunspell")
(setq ispell-local-dictionary-alist
      `(("american" "[[:alpha:]]" "[^[:alpha:]]" "[']" t ("-d" "en_US") nil
         utf-8)))

(defun toggle-letter-case ()
  "Toggle the letter case of current word or text selection.
Toggles between: “all lower”, “Init Caps”, “ALL CAPS”."
  (interactive)
  (let (p1 p2 (deactivate-mark nil) (case-fold-search nil))
    (if (region-active-p)
        (setq p1 (region-beginning) p2 (region-end))
      (let ((bds (bounds-of-thing-at-point 'word) ) )
        (setq p1 (car bds) p2 (cdr bds)) ) )

    (when (not (eq last-command this-command))
      (save-excursion
        (goto-char p1)
        (cond
         ((looking-at "[[:lower:]][[:lower:]]") (put this-command 'state "all lower"))
         ((looking-at "[[:upper:]][[:upper:]]") (put this-command 'state "all caps") )
         ((looking-at "[[:upper:]][[:lower:]]") (put this-command 'state "init caps") )
         ((looking-at "[[:lower:]]") (put this-command 'state "all lower"))
         ((looking-at "[[:upper:]]") (put this-command 'state "all caps") )
         (t (put this-command 'state "all lower") ) ) )
      )

    (cond
     ((string= "all lower" (get this-command 'state))
      (upcase-initials-region p1 p2) (put this-command 'state "init caps"))
     ((string= "init caps" (get this-command 'state))
      (upcase-region p1 p2) (put this-command 'state "all caps"))
     ((string= "all caps" (get this-command 'state))
      (downcase-region p1 p2) (put this-command 'state "all lower")) )
    )
  )
;;set this to M-c
(global-set-key "\M-c" 'toggle-letter-case)

(setq set-mark-command-repeat-pop t)

(global-set-key (kbd "M-/") 'hippie-expand)
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-file-name-partially
        try-complete-file-name
        try-expand-all-abbrevs
        try-expand-list
        try-expand-line
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol))

(setq-default abbrev-mode t)
(setq save-abbrrevs 'silently)                ;; save abbreviations upon exiting emacs
(if (file-exists-p abbrev-file-name)
  (quitely-read-abbrev-file))                 ;; read the abbreviations file on startup

(setq-default indent-tabs-mode nil)

(delete-selection-mode t)

(setq mouse-drag-copy-region t)

(setq save-interprogram-paste-before-kill t)

(use-package cua-base
  :init
  (progn
    (cua-mode 1)
    (cua-selection-mode t))
  :config
  (progn
    (setq cua-enable-cua-keys nil)		;;only for rectangles
    (setq cua-auto-tabify-rectangles nil)))     ;; don't tabify after rectangles commands

(use-package anzu
  :diminish anzu-mode
  :bind (("M-%" . anzu-query-replace)
         ("C-M-%" . anzu-query-replace-regexp))
  :config
  (global-anzu-mode))

;; multiple cursors
(use-package multiple-cursors
  :ensure t
  :bind (("C-c m c" . mc/edit-lines)
         ("C-S-c C-S-c" . mc/edit-lines)
         ("M-." . mc/mark-next-like-this)
         ("M-," . mc/unmark-next-like-this)
         ("C-S-<mouse-1>" . mc/add-cursor-on-click)
         ("C-'" . mc-hide-unmatched-lines)))

;; expand region with a key
(use-package expand-region
  :bind ("C-=" . er/expand-region))

(setq undo-tree-mode t)

(use-package yasnippet
  :ensure t
  :diminish yas-minor-mode
  :bind(("C-c ( C-n" . yas-new-snippet)
        ("C-c ( C-s " . yas-insert-snippet)
        ("C-c ( C-v" . yas-visit-snippet-file))
  :config
  (yas-global-mode 1)
  (setq yas-indent-line nil))

(use-package shrink-whitespace
  :ensure t
  :bind (("M-s SPC" . shrink-whitespace)))

(add-hook 'before-save-hook 'whitespace-cleanup)

(use-package easy-kill
  :ensure t
  :bind (([remap kill-ring-save] . easy-kill)))

(require 'rect)
(defadvice kill-region (before smart-cut activate compile)
  "when called interactively with no active region,kill a single line instead."
(interactive
(if mark-active (list (region-beginning) (region-end) rectangle-mark-mode)
  (list (line-beginning-position)
        (line-beginning-position 2)))))

(setq dired-listing-switches "-alh --group-directories-first")
;; l: Is the only mandatory one.
;; a: Means to list invisible files.
;; G: Don't show group information. These days, when there are more laptops than people, the group info is rarely useful.
;; h: Human readable sizes, such as M for mebibytes.
;; 1v: Affects the sorting of digits, hopefully in a positive way.
;; --group-directories-first: self-explanatory, I like to have the directories on the top, separate from the files.

(recentf-mode 1)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; helm setting
(helm-mode 1)
(require 'helm)
(require 'helm-config)

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t
      helm-echo-input-in-header-line t)

(defun spacemacs//helm-hide-minibuffer-maybe ()
  "Hide minibuffer in Helm session if we use the header line as input field."
  (when (with-helm-buffer helm-echo-input-in-header-line)
    (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
      (overlay-put ov 'window (selected-window))
      (overlay-put ov 'face
                   (let ((bg-color (face-background 'default nil)))
                     `(:background ,bg-color :foreground ,bg-color)))
      (setq-local cursor-type nil))))


(add-hook 'helm-minibuffer-set-up-hook
          'spacemacs//helm-hide-minibuffer-maybe)

(setq helm-autoresize-max-height 0)
(setq helm-autoresize-min-height 40)
(helm-autoresize-mode 1)
(setq helm-M-x-fuzzy-match t) ;; optional fuzzy matching for helm-M-x


;; active semantic
(setq helm-semantic-fuzzy-match t
      helm-imenu-fuzzy-match t)

;; helm man and woman
(add-to-list 'helm-sources-using-default-as-input 'helm-source-man-pages)
;; helm locate
(setq helm-locate-fuzzy-match t)
;; helm apropos
(setq helm-apropos-fuzzy-match t)
(setq helm-lisp-fuzzy-completion t)

(require 'helm-descbinds)
(helm-descbinds-mode)


;; active helm grep,just use C-s will have pattern,just like helm-occur
(when (executable-find "ack-grep")
  (setq helm-grep-default-command "ack-grep -Hn --no-group --no-color %e %p %f"
        helm-grep-default-recurse-command "ack-grep -H --no-group --no-color %e %p %f"))

;; helm eshell history
(require 'helm-eshell)

(add-hook 'eshell-mode-hook
          #'(lambda ()
              (define-key eshell-mode-map (kbd "C-c C-l")  'helm-eshell-history)))

;; helm key bind

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.

(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)

;; insert-buffer
(global-set-key (kbd "C-c C-i") 'insert-buffer)

;; helm-show-kill-ring
(global-set-key (kbd "M-y") 'helm-show-kill-ring)

; helm-mini
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)

;; enable fuzzy matching
(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match t)

;; helm occur
(global-set-key (kbd "C-c h o") 'helm-occur)

;; helm all mark rings
(global-set-key (kbd "C-h SPC") 'helm-all-mark-rings)

;; helm register
(global-set-key (kbd "C-c h x") 'helm-register)

;;helm  google suggest
(global-set-key (kbd "C-c h g") 'helm-google-suggest)

;; helm eval expression with eldoc
(global-set-key (kbd "C-c h M-:") 'helm-eval-expression-with-eldoc)

;;helm-calcul-expression
(global-set-key (kbd "C-c h C-c") 'helm-calcul-expression)
(global-set-key (kbd "C-x r l") 'helm-bookmarks)
(global-set-key (kbd "C-x r m") 'bookmark-set)

(use-package projectile
  :ensure t
  :config
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1))

(use-package elpy
  :ensure t
  :init
  (advice-add 'python-mode :before 'elpy-enable))

;; syntax highlighting for html export
(use-package htmlize
:ensure t)

(require 'org)
(use-package org
  :bind (("C-c l" . org-store-link)
         ("C-c a" . org-agenda)
         ("C-c c" . org-capture))
         :config
         (setq org-log-done t))

(require 'org)
;; ignore evaluate message
(setq org-edit-src-content-indentation 0
      org-src-tab-acts-natively t
      org-src-fontify-natively t
      org-confirm-babel-evaluate nil
      )

(defun endless/org-ispell ()
  "Configure `ispell-skip-region-alist' for `org-mode'."
  (make-local-variable 'ispell-skip-region-alist)
  (add-to-list 'ispell-skip-region-alist '(org-property-drawer-re))
  (add-to-list 'ispell-skip-region-alist '("~" "~"))
  (add-to-list 'ispell-skip-region-alist '("=" "="))
  (add-to-list 'ispell-skip-region-alist '("^#\\+BEGIN_SRC" . "^#\\+END_SRC")))
(add-hook 'org-mode-hook #'endless/org-ispell)

;; Tangle Org files when we save them
(defun tangle-on-save-org-mode-file()
  (when (string= (message "%s" major-mode) "org-mode")
    (org-babel-tangle)))

(add-hook 'after-save-hook 'tangle-on-save-org-mode-file)

;; Enable the auto-revert mode globally. This is quite useful when you have
;; multiple buffers opened that Org-mode can update after tangling.
;; All the buffers will be updated with what changed on the disk.
(global-auto-revert-mode)

;; Add Org files to the agenda when we save them
(defun to-agenda-on-save-org-mode-file()
  (when (string= (message "%s" major-mode) "org-mode")
    (org-agenda-file-to-front)))

(add-hook 'after-save-hook 'to-agenda-on-save-org-mode-file)

;; you could use `C-c C-x C-v` toggle enable inline image
(defun turn-on-org-show-all-inline-images()
  (org-display-inline-images t))
(add-hook 'org-mode-hook 'turn-on-org-show-all-inline-images)

;; Remove the markup characters, i.e., "/text/" becomes (italized) "text"
(setq org-hide-emphasis-markers t)

;; turn on visual-line-mode for org-mode only
;; also install "adaptive-wrap" from epla
(add-hook 'org-mode-hook 'turn-on-visual-line-mode)

;; CUSTOMISE - you could put a different css file here
;; or nothing at all
(setq org-html-head "<link rel=\"stylesheet\" type=\"text/css\" href=\"http://www.star.bris.ac.uk/bjm/css/bjm.css\" />
<link rel=\"stylesheet\" type=\"text/css\" href=\"bjm.css\" />")

;; short-cuts for common tags
(setq org-tag-alist '(("export" . ?e) ("noexport" . ?n)))

;; use tcsh for shell scripts
;; customize - replace with sh, zsh if you prefer
;;(setq org-babel-sh-command "/bin/tcsh")

;; display results in a block instead of prefixed with :
(setq org-babel-min-lines-for-block-output 1)

;; Some initial languages we want org-babel to support

;; see link: https://github.com/tkf/org-mode/blob/master/lisp/ob-python.el
;; config org-babel
(eval-after-load 'org
  (lambda()
    (require 'ob-python)
    (require 'ob-org)
    (require 'ob-shell)
    (require 'ob-dot)
    (require 'ob-plantuml)
    ))

;; parse tree when you frequently search specified string
(setq org-agenda-custom-commands
      '(("g" occur-tree "revolt")))

(setq org-agenda-files '("~/org/inbox.org"
                         "~/org/gtd.org"
                         "~/org/tickler.org"))

(setq org-capture-templates '(("t" "Todo [inbox]" entry
                               (file+headline "~/org/inbox.org" "Tasks")
                               "* TODO %i%?")
                              ("T" "Tickler" entry
                               (file+headline "~/org/tickler.org" "Tickler")
                               "* %i%? \n %U")))

(setq org-image-actual-width t)

(use-package org-bullets
  :config
  (setq org-bullets-bullet-list '("◉" "◎" "✽" "✽" "♡" "❀"))
  (add-hook 'org-mode-hook
            (lambda () (org-bullets-mode 1))))

;; disable CJK coding/encoding (Chinese/Japanese/Korean characters)
(setq utf-translate-cjk-mode nil)

(set-language-environment 'utf-8)
(setq locale-coding-system 'utf-8)

;; set the default encoding system
(prefer-coding-system 'utf-8)
(setq default-file-name-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
;; backwards compatibility as default-buffer-file-coding-system
;; is deprecated in 23.2.
(if (boundp buffer-file-coding-system)
    (setq buffer-file-coding-system 'utf-8)
  (setq default-buffer-file-coding-system 'utf-8))

;; Treat clipboard input as UTF-8 string first; compound text next, etc.
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

(autoload 'footnote-mode "footnote" nil t)
;; Example for Gnus. If you use an other mailer you will replace the hook with the appropriated hook of your mailer.
(add-hook 'message-mode-hook 'footnote-mode)

(add-hook 'message-mode-hook 'turn-on-orgtbl)

(global-set-key (kbd "M-C-g") 'org-plot/gnuplot)

(global-set-key (kbd "C-c &") 'org-mark-ring-goto)

;; install plantuml-mode
;; load plantuml
(setq org-plantuml-jar-path (expand-file-name "~/org/.plantuml/plantuml.jar"))
;; helper function
(defun my-org-confirm-babel-evaluate (lang body)
  "Do not ask for confirmation to evaluate code for specified languages。"
  (member lang '("plantuml")))

;; trust certain code as being safe
(setq org-confirm-babel-evaluate 'my-org-confirm-babel-evaluate)

;; automatically show the resulting image
(add-hook 'org-babel-after-execute-hook 'org-display-inline-images)
