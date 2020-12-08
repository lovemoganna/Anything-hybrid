;; [[file:~/.emacs.d/init.org::*Auto Tangle][Auto Tangle:1]]
;;-*-emacs-lisp-*- -*-lexical-binding: t;-*-

;; Copyright (C) 2020 Mr.Revolt

;; Author: Mr.Revolt
;; Keywords: keybinding configuration

;;; Commentary:

;; Anything Keybinding configuration

;;; Code:

(defun revolt/make-init-el-and-starup ()
  "Tangle init.el and a startup file in init.org"
  (interactive "P")			;; places value of universal argument into: `current-prefix-arg'
  (when current-prefix-arg
    (message "You update emacs configure file successed...")
    (let* ((time (current-time))
           (_date (format-time-string "_%Y-%m-%d"))
           (.emacs "~/.emacs")
           (.emacs.el "~/.emacs.el"))
      (message "%S"  (list time _date .emacs .emacs.el))

      ;; Make init.el
      (org-babel-tangle)
      ;; (byte-compile-file "~/.emacs.d/init.el")
      (load-file "~/.emacs.d/init.el")

      ;; Make README.org
      (save-excursion
        (org-babel-goto-named-src-block "get-started") ;; See next subsubsection.
        (org-babel-execute-src-block))

      (message "Tangled, compiled, and loaded init.el; and made README.md … %.06f seconds"
               (float-time (time-since time))))))

(add-hook 'after-save-hook 'revolt/make-init-el-and-starup nil 'local-to-this-file-please)
;; Auto Tangle:1 ends here

;; [[file:~/.emacs.d/init.org::get-started][get-started]]
(message "hello world")			;test demo
;; get-started ends here

;; [[file:~/.emacs.d/init.org::*Emacs statup message][Emacs statup message:1]]
;; Silence the usual message: Get more info using the about page via C-h C-a.
(setq inhibit-startup-message t)

(defun display-startup-echo-area-message ()
  "The message that is shown after ‘user-init-file’ is loaded."
  (message
   (concat "Welcome "      user-full-name
           "! Emacs "      emacs-version
           "; Org-mode "   (org-version)
           "; System "     (symbol-name system-type)
           "/"             (system-name)
           "; Time "       (emacs-init-time))))
;; Keep self motivated!
(setq frame-title-format '("" "%b - Living The Dream (•̀ᴗ•́)و"))
;; Emacs statup message:1 ends here

;; [[file:~/.emacs.d/init.org::*Custom setting][Custom setting:1]]
(setq custom-file "~/.emacs.d/custom.el")
(ignore-errors (load custom-file)) ;; It may not yet exist.
(setq enable-local-variables :safe)
;; Custom setting:1 ends here

;; [[file:~/.emacs.d/init.org::*Package Source][Package Source:1]]
;; Emacs package source
(require 'package)

;; slove contract melpa.gnu.org:443 question
;; https://www.reddit.com/r/emacs/comments/cdei4p/failed_to_download_gnu_archive_bad_request/etw48ux
;; https://stackoverflow.com/questions/29085937/package-refresh-contents-hangs-at-contacting-host-elpa-gnu-org80
;; Make all commands of the “package” module present.

(setq package-archives '(("org"       . "http://orgmode.org/elpa/")
                         ("gnu"       . "http://elpa.gnu.org/packages/")
                         ("melpa"     . "http://melpa.org/packages/")))

;; (package-initialize)

;; (package-refresh-contents)

;; China Tuna Package Source
;;(setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
;;				 ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))

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
;; Package Source:1 ends here

;; [[file:~/.emacs.d/init.org::*Maintain already installed package][Maintain already installed package:1]]
;; Package list
(defvar revolt/package-list
  '(
    better-defaults
    smartparens
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
    pdf-tools
    ox-hugo
    web-mode
    web-beautify
    svelte-mode
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
    company
    company-web
    ob-go
    company-go
    tern
    bind-key
    golden-ratio
    ace-window
    lsp-mode
    yaml-mode
    company-lsp
    evil-terminal-cursor-changer
    exec-path-from-shell
    doom-themes
    google-translate
    undo-tree
    highlight-symbol
    vterm
    org-download
    rainbow-delimiters
    ))

(setq package-selected-packages revolt/package-list)

;; Check my installed package state

(require 'cl)
(defun revolt/packages-installed-p()
  (loop for pkg in revolt/package-list
        when (not (package-installed-p pkg))
        do (return nil)
        finally (return t)
        ))

;; Fetch the list of package available
;; (unless package-archive-contents
;;   (package-refresh-contents))

;; Refersh package database and install it when package not installed
;; (unless (revolt/packages-installed-p)
;;   (message "%s" "Searching you lost package......")
;;   (package-refresh-contents)
;;   (message "%s" "Refersh successed melpa library!")
;;   (dolist (pkg revolt/package-list)
;;     (when (not (package-installed-p pkg))
;;       (package-install pkg))))

;; List the packages you want & install the missing packages
(dolist (revolt/package revolt/package-list)
  (unless (package-installed-p revolt/package)
    (package-install revolt/package)))
;; (require 'better-defaults)
;; Maintain already installed package:1 ends here

;; [[file:~/.emacs.d/init.org::*Use quelpa manage emacs package][Use quelpa manage emacs package:1]]
;; use quelpa manage pacakge
(unless (package-installed-p 'quelpa)
  (with-temp-buffer
    (url-insert-file-contents "https://raw.githubusercontent.com/quelpa/quelpa/master/quelpa.el")
    (eval-buffer)
    (quelpa-self-upgrade)))
;; (quelpa '(org-download :repo "abo-abo/org-download" :fetcher github))
;; Use quelpa manage emacs package:1 ends here

;; [[file:~/.emacs.d/init.org::*GUI configure][GUI configure:1]]
;; 关闭工具栏，Tool-Bar-Mode 即为一个 Minor Mode
(tool-bar-mode -1)
(menu-bar-mode -1)

;; 关闭文件滑动控件
(scroll-bar-mode -1)

;; 设置EMACS ORG MODE 下的文字间距
;; 显示行号
;; (global-linum-mode 1)

(setq-default line-spacing 0.4)

;; Set TAB key default indentation
;; disable default tab width
;; (setq-default tab-width 2)

;; 关闭备份文件
(setq make-backup-files nil)

;; 关闭启动帮助画面
(setq inhibit-splash-screen t
      initial-scratch-message "Welcome Elisp killing of the Sea! \n\n"
      ;; initial-major-mode 'org-mode
      )

;; 开启全局 Company 补全
;; (global-company-mode 1)

;; different state cursor form
(setq-default cursor-type 'bar)

;; simple request
(fset 'yes-or-no-p 'y-or-n-p)

;; show time in mode line
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(display-time)

;; highlight selected area
(transient-mark-mode t)

;; 显示匹配的括号
(show-paren-mode t)

;; disable create bak file
(setq-default make-backup-files nil)

;; 括号自动补全
(electric-pair-mode 1)

;; auto fill mode
(add-hook 'org-mode-hook 'turn-on-auto-fill)

;; UTF-8 as default encoding
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8-unix)

;; hacks to reduce the startup time.
(setq gc-cons-threshold (expt 2 24))
(setq load-prefer-newer t)

;; personal information
;; (setq user-full-name "revolt")
;; GUI configure:1 ends here

;; [[file:~/.emacs.d/init.org::*Font][Font:1]]
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
    (add-to-list 'initial-frame-alist '(font . "Iosevka fixed SS02-14"))
    (add-to-list 'default-frame-alist '(font . "Iosevka fixed SS14-14")))))

;; set font all windows. don't keep window size fixed
;; (set-frame-font "Iosevka Fixed SS14" nil t)
;; you must set the `pixelsize` the font will show beautiful!
;; (set-frame-font "Fira Code-12:style=Medium,Regular:antialias=True:pixelsize=14" nil t)
(set-frame-font "Roboto Mono-10:style=Regular,Medium,Bold,Italic,Thin:antialias=True:pixelsize=12" nil t)


;; Chinese Font -- 中文字体的话，必须设置为 14px，才能使Org Mode里面的Table对齐。很是Fuck。

;; ref link: https://emacs-china.org/t/org-mode/440/52
;; https://emacs-china.org/t/org-mode-9-3/11217/12

;; slove tty font does not exit problem: https://lists.gnu.org/archive/html/emacs-devel/2006-12/msg00285.html

(if (display-graphic-p)
    (dolist (charset '(kana han symbol cjk-misc bopomofo))
      (set-fontset-font (frame-parameter nil 'font)
                        ;; WenQuanYi Zen Hei
                        ;;charset (font-spec :family "WenQuanYi Zen Hei Mono Light"
                        charset (font-spec :family "HYQiHeiX1\-45W"
                                           ;; charset (font-spec :family "TsangerJinKai03\-6763 W03"
                                           :pixels 16
                                           :size 13)))) ;理解万岁

(require 'org-faces)
(set-face-attribute 'org-table nil :family "HYQiHeiX1\-45W")

(setq org-hide-emphasis-markers t)
(font-lock-add-keywords 'org-mode
                        '(("^ *\\([-]\\) "
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
;; Font:1 ends here

;; [[file:~/.emacs.d/init.org::*theme][theme:1]]
(load-theme 'doom-dracula t)

;; set transparency
(set-frame-parameter (selected-frame) 'alpha '(90 90))
(add-to-list 'default-frame-alist '(alpha 90 90))

;; (load-theme 'vivid t)
;; Nice,the answer in here
;; https://stackoverflow.com/questions/18684579/how-do-i-change-the-highlight-color-for-selected-text-with-emacs-deftheme
(set-face-attribute 'region nil :background "#FBD7CF")
(provide 'init-global-themes)
;; theme:1 ends here

;; [[file:~/.emacs.d/init.org::*symbol face][symbol face:1]]
;; 全局启动符号美化
(global-prettify-symbols-mode)
;; (defconst lisp--prettify-symbols-alist
;;   '(("lambda"  . ?λ)))
;; symbol face:1 ends here

;; [[file:~/.emacs.d/init.org::*init-key-binding][init-key-binding:1]]
;; recentf open file
(defun open-recentf-files()
  (interactive)
  (recentf-mode)
  (recentf-open-files))

;; (global-set-key (kbd "C-x C-r") 'open-recentf-files)
(global-set-key (kbd "C-x C-r") 'helm-recentf)

;; store org link
(global-set-key (kbd "C-c l") 'org-store-link)

(with-eval-after-load
    ;; which key mode
    (require 'which-key)
  ;; (which-key-setup-side-window-bottom)

  (which-key-setup-side-window-bottom)
  ;; which-key 延迟太高,需要降低,激活键是 `C-x`

  ;; Set the time delay (in seconds) for the which-key popup to appear. A value of
  ;; zero might cause issues so a non-zero value is recommended.
  (setq which-key-idle-delay 1)
  ;; whick-key的触发，与C-h有关，所以现在变为 `C-x C-h'
  ;; (setq which-key-show-early-on-C-h t)
  (setq which-key-idle-secondary-delay 0.01)

  ;; Set the maximum length (in characters) for key descriptions (commands or
  ;; prefixes). Descriptions that are longer are truncated and have ".." added.
  (setq which-key-max-description-length 27)

  ;; Use additional padding between columns of keys. This variable specifies the
  ;; number of spaces to add to the left of each column.
  (setq which-key-add-column-padding 0)
  (which-key-mode)
  )
;; init-key-binding:1 ends here

;; [[file:~/.emacs.d/init.org::*firefox browser setting][firefox browser setting:1]]
;; (setq browse-url-browser-function 'browse-url-firefox)

;; ;; 给w3m 浏览器设置代理

;; (setq w3m-command "~/.emacs.d/lisp/customize/w3m.sh")


;; ;; use w3m as default browser
;; (setq browse-url-browser-function 'w3m-browse-url)
;; (setq w3m-view-this-url-new-session-in-background t)


;; (add-to-list 'load-path "/usr/bin/w3m")
;; (require 'w3m-load)

;; (autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)

;; ;; set w3m homepage
;; (setq w3m-home-page "http://www.google.com")

;; ;; defalut show image
;; (setq w3m-default-display-inline-images t)
;; (setq w3m-toggle-inline-images-permanently t)

;; ;; use cookie
;; (setq w3m-use-cookies t)

;; ;; keyboard short-cut
;; (global-set-key "\C-xm" 'browse-url-at-point)

;; ;; show icons
;; (setq w3m-show-graphic-icons-in-header-line t)
;; (setq w3m-show-graphic-icons-in-mode-line t)
;; firefox browser setting:1 ends here

;; [[file:~/.emacs.d/init.org::*svg label][svg label:1]]
(require 's)
(require 'svg)

(defface tag-face
  '((t :foreground "white" :background "orange" :box "orange"
       :family "Roboto Mono" :weight medium :height 160))
  "Default face for tag" :group 'tag)

(defun tag (text &optional face inner-padding outer-padding radius)
  (let* ((face       (or face 'tag-face))
         (foreground (face-attribute face :foreground))
         (background (face-attribute face :background))
         (border     (face-attribute face :box))
         (family     (face-attribute face :family))
         (weight     (face-attribute face :weight))
         (size       (/ (face-attribute face :height) 9))

         (tag-char-width  (window-font-width nil face))
         (tag-char-height (window-font-height nil face))
         (txt-char-width  (window-font-width))
         (txt-char-height (window-font-height))
         (inner-padding   (or inner-padding 0))
         (outer-padding   (or outer-padding 0))

         (text (s-trim text))
         (tag-width (* (+ (length text) inner-padding) txt-char-width))
         (tag-height (* txt-char-height  1.4))

         (svg-width (+ tag-width (* outer-padding txt-char-width)))
         (svg-height tag-height)

         (tag-x (/ (- svg-width tag-width) 1))
         (text-x (+ tag-x (/ (- tag-width (* (length text) tag-char-width)) 0.5)))
         (text-y (- tag-char-height (- txt-char-height tag-char-height)))

         (radius  (or radius 3))
         (svg (svg-create svg-width svg-height)))

    (svg-rectangle svg tag-x 0 tag-width tag-height
                   :fill        border
                   :rx          radius)
    (svg-rectangle svg (+ tag-x 1) 1 (- tag-width 2) (- tag-height 2)
                   :fill        background
                   :rx          (- radius 1))
    (svg-text      svg text
                   :font-family family
                   :font-weight weight
                   :font-size   size
                   :fill        foreground
                   :x           text-x
                   :y           text-y)
    (svg-image svg :ascent 'center)))

(defface tag-note-face
  '((t :foreground "black" :background "yellow" :box "black"
       :family "Roboto Mono" :weight medium :height 120))
  "Face for note tag" :group 'tag)

(defface tag-key-face
  '((t :foreground "#333333" :background "#f0f0f0" :box "#999999"
       :family "Roboto Mono" :weight medium :height 120))
  "Face for key tag" :group 'tag)

(setq tag-todo (tag "TODO" nil 1 1 3))
(setq tag-note (tag "NOTE" 'tag-note-face 1 1 3))


;; A tag function using SVG to display a rounded box with outer and inner
;; padding and a controllable box radius. The resulting SVG is perfectly
;; aligned with regular text such that a =TAG= can be inserted and edited
;; anywhere in the text thanks to font-lock and the display property.

(add-to-list 'font-lock-extra-managed-props 'display)
(font-lock-add-keywords nil
                        '(("\\(\:TODO\:\\)" 1 `(face nil display ,tag-todo))
                          ("\\(\:NOTE\:\\)" 1 `(face nil display ,tag-note))
                          ("\\(=[0-9a-zA-Z- ]+?=\\)" 1
                           `(face nil display
                                  ,(tag (substring (match-string 0) 1 -1) 'tag-key-face 1 1 3)))))

;; |:TODO:| Make a minor mode
;; |:NOTE:| Don't know how to do it, help needed…
;; | :______: | Perfect alignment with regular text
;; :TODO:
;;  Save ................. =C-x=+=C-s=  Help ............... =C-h=
;;  Save as .............. =C-x=+=C-w=  Cancel ............. =C-g=
;;  Open a new file ...... =C-x=+=C-f=  Undo ............... =C-z=
;;  Open recent .......... =C-x=+=C-r=  Close buffer ....... =C-x=+=k=
;;  Browse directory ......=C-x=+=d=    Quit ............... =C-x=+=C-c=
;; svg label:1 ends here

;; [[file:~/.emacs.d/init.org::*ob-markdown][ob-markdown:1]]
;; ref: https://github.com/tnoda/ob-markdown
(require 'ob)
(require 'ob-eval)
(require 'markdown-mode)
;; possibly require modes required for your language

;; optionally define a file extension for this language
(add-to-list 'org-babel-tangle-lang-exts '("markdown" . "text"))

;; optionally declare default header arguments for this language
(defvar org-babel-default-header-args:markdown '())

;; This function expands the body of a source code block by doing
;; things like prepending argument definitions to the body, it should
;; be called by the `org-babel-execute:markdown' function below.
(defun org-babel-expand-body:markdown (body params &optional processed-params)
  "Expand BODY according to PARAMS, return the expanded body."
  body)

(defun org-babel-execute:markdown (body params)
  "Execute a block of Markdown code with org-babel.  This function is
    called by `org-babel-execute-src-block'."
  (message "executing Markdown source code block")
  (org-babel-eval markdown-command (org-babel-expand-body:markdown body params)))

;; This function should be used to assign any variables in params in
;; the context of the session environment.
(defun org-babel-prep-session:markdown (session params)
  "Return an error if the :session header argument is Set.
    Markdown does not support sessions."
  (error "Markdown sessions are nonsensical."))

(provide 'ob-markdown)
;; ob-markdown:1 ends here

;; [[file:~/.emacs.d/init.org::*org babel][org babel:1]]
;; Active Org mode babel support language
;; ref link: http://archive.3zso.com/archives/orgmode-babel.html
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (shell . t)
   (scheme . t)
   (markdown . t)
   (js . t)
   (R . t)
   (dot . t)
   (css . t)
   (http . t)
   (latex .t)
   (org . t)
   (perl . t)
   (ruby . t)
   (go . t)
   (python . t)))

;; (defun my-org-confirm-babel-evaluate (lang body)
;;   (not (string= lang "emacs-lisp")))  ;don't ask for ditaa
;; (setq org-confirm-babel-evaluate #'my-org-confirm-babel-evaluate)

;; let Org-mode Babel src code block auto set `web-mode-engine' for rhtml.
(defadvice org-edit-special (before org-edit-src-code activate)
  (let ((lang (nth 0 (org-babel-get-src-block-info))))
    (if (string= lang "rhtml")
        (web-mode-set-engine "erb"))
    ))
;; org babel:1 ends here

;; [[file:~/.emacs.d/init.org::*Org bullet][Org bullet:1]]
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(setq org-bullets-bullet-list '("🦄" "♈" "🕊" "🐱" "🎉" "♥"))
;; Org bullet:1 ends here

;; [[file:~/.emacs.d/init.org::*Org Capture && Org Agenda][Org Capture && Org Agenda:1]]
(global-set-key (kbd "C-c a") 'org-agenda)
;; Org Capture && Org Agenda:1 ends here

;; [[file:~/.emacs.d/init.org::*Image size setting][Image size setting:1]]
;; (setq org-image-actual-width nil)

;; org redisplay inline images
(add-hook 'org-babel-after-execute-hook 'org-redisplay-inline-images)
;; Image size setting:1 ends here

;; [[file:~/.emacs.d/init.org::*customize setting org header properties][customize setting org header properties:1]]
;; (require 'org-id)

;; (save-excursion
;;       (goto-char (point-max))
;;       (while (outline-previous-heading)
;;         (org-id-get-create)))

;; add tangle-dir property

(defun org-in-tangle-dir (sub-path)
  "Expand the SUB-PATH into the directory given by the tangle-dir
       property if that property exists, else use the
       `default-directory'."
  (expand-file-name sub-path
                    (or
                     (org-entry-get (point) "tangle-dir" 'inherit)
                     (default-directory))))
;; customize setting org header properties:1 ends here

;; [[file:~/.emacs.d/init.org::*Org highlight code && available indent][Org highlight code && available indent:1]]
;; syntax highlight code

;; 解决org mode中代码高亮 + 代码导出正确缩进
;; https://github.com/kaushalmodi/ox-hugo/issues/314
;; https://emacs.stackexchange.com/questions/18877/how-to-indent-without-the-two-extra-spaces-at-the-beginning-of-code-blocks-in-or/18892#18892

(setq org-confirm-babel-evaluate nil
      org-src-fontify-natively t
      org-src-window-setup 'current-window
      org-src-strip-leading-and-trailing-blank-lines t
      org-src-preserve-indentation t
      org-src-tab-acts-natively t)

(setq org-startup-indented t)

;; default hidden org block
;; (setq org-hide-block-startup t)

;; import org font
;; (require 'init-org-font "./org-font/init-org-font")

;; use org auto complete extension: org-ac
;; (require 'org-ac)
;; (org-ac/config-default)
;; Org highlight code && available indent:1 ends here

;; [[file:~/.emacs.d/init.org::*Org default dir][Org default dir:1]]
(setq org-directory "~/.emacs.d/.org/")
;; Org default dir:1 ends here

;; [[file:~/.emacs.d/init.org::*for every assign a id][for every assign a id:1]]
(setq org-id-link-to-org-use-id 'create-if-interactive)
;; for every assign a id:1 ends here

;; [[file:~/.emacs.d/init.org::*使用 Org refile 归档或者跳转到标题][使用 Org refile 归档或者跳转到标题:1]]
(setq org-refile-targets '((org-agenda-files . (:maxlevel . 7))))
;; 使用 Org refile 归档或者跳转到标题:1 ends here

;; [[file:~/.emacs.d/init.org::*Use org-capture to write notes quickly][Use org-capture to write notes quickly:1]]
(global-set-key (kbd "C-c c") 'org-capture)
(setq org-default-notes-file "~/.emacs.d/.agenda/task_index.org")
;; Use org-capture to write notes quickly:1 ends here

;; [[file:~/.emacs.d/init.org::*Configure Emacs][Configure Emacs:1]]
(server-start)
;; (add-to-list 'load-path "~/.emacs.d/.org/protocol/")
;; Emacs 内置，不需要外部引入
(require 'org-protocol)
;; Configure Emacs:1 ends here

(add-to-list 'load-path "~/.emacs.d/.utils/org-protocol-capture-html/")
(require 'org-protocol-capture-html)

;; ref link: https://www.zmonster.me/2018/02/28/org-mode-capture.html
(defun org-capture-template-goto-link ()
  (org-capture-put :target (list 'file+headline
                                 (nth 1 (org-capture-get :target))
                                 (org-capture-get :annotation)))
  (org-capture-put-target-region-and-position)
  (widen)
  (let ((hd (nth 2 (org-capture-get :target))))
    (goto-char (point-min))
    (if (re-search-forward
         (format org-complex-heading-regexp-format (regexp-quote hd)) nil t)
        (org-end-of-subtree)
      (goto-char (point-max))
      (or (bolp) (insert "\n"))
      (insert "* " hd "\n"))))

(setq org-capture-templates
      '(
        ;; 定义协议组,ref link: https://github.com/progfolio/doct
        ("p" "capture protocol group")
        ("pb" "Protocol Bookmarks" entry
         (file+headline "~/.emacs.d/.org/web.org" "Bookmarks")
         "* %U - %:annotation"
         :immediate-finish t
         :kill-buffer t
         :prepend t)
        ("pn" "Protocol"
         entry (file+headline "~/.emacs.d/.org/web.org" "New Notes")
         "* %:description :RESEARCH:\n#+BEGIN_QUOTE\n%i\n\n -- %:link %u\n #+END_QUOTE\n\n%?"
         :prepend t)
        ("ph" "Protocol Bookmarks" entry
         (file+headline "~/.emacs.d/.org/web.org" "Notes")
         "* %U - %:annotation %^g\n\n  %?"
         :empty-lines 1
         :kill-buffer t
         :prepend t
         )

        ;; 追加内容，依托于 org-capture firefox/chrome 插件，函数参考：
        ("pl" "Protocol Annotation" plain
         (file+function "~/.emacs.d/.org/web.org" org-capture-template-goto-link)
         "%U  %?\n\n  %:initial"
         :empty-lines 1
         :prepend t
         )

        ;; 结合Firefox上面的书签制作书签管理器,依靠 org-protocol-capture-html
        ("w" "Web site" entry
         (file+headline "~/.emacs.d/.org/web.org" "Bookmarks")
         "** %a :website:\n\n%U %?\n\n%:initial")

        ;; 定义普通任务
        ("t" "Todo"
         entry (file+headline "~/.emacs.d/.org/notes/gtd.org" "Tasks"))

        ;; 以时间为 heading,记录你当天做了啥事
        ("j" "Journal" entry (file+datetree "~/.emacs.d/.org/notes/journal.org")
         "* %?\nEntered on %U\n  %i\n  %a")

        
        ("L" "Protocol Link"
         entry (file+headline "~/.emacs.d/.org/web.org" "New Notes")
         "* %? [[%:link][%:description]] \nCaptured On: %u")
        ))

;; [[file:~/.emacs.d/init.org::*Evil][Evil:1]]
(require 'evil)
(require 'evil-leader)

(global-evil-leader-mode)
(evil-mode 1)

;; define evil key binding
(define-key evil-ex-map "o" 'helm-occur)

(setq evil-insert-state-cursor '((bar . 3) "orange red")
      evil-normal-state-cursor '(box "purple"))

(defun open-my-init-file()
  "快速打开配置文件."
  (interactive)
  (find-file "~/.emacs.d/init.el")
  (eval-buffer)
  (find-file "~/.emacs.d/lisp/init-package.org")
  )

;; vim command cookbook: http://tnerual.eriogerg.free.fr/vimqrc.pdf

(defalias 'sc 'shell-command)
(defun gif-record()
  "在当前文件夹中生成GIF图."
  (interactive)
  (sc "~/.emacs.d/lisp/private/shell_tools/byzanz-record-region.sh 10 'screen'_$(date +'%Y.%m.%d-%H:%M:%S').gif")
  (message "GIF 图生成在当前的文件夹")
  )

(defun format-paragraph()
  "填充式格式化当前段落"
  (interactive)
  (mark-paragraph)
  (interactive)
  (fill-region)
  )

(defun quick-open-org-main-file()
  "Quick open Org main file for take notes"
  (interactive)
  (find-file "~/.emacs.d/.org/notes/organizer.org")
  )

(set-register ?o (cons 'file "~/.emacs.d/.org/notes/organizer.org"))

;; need install general.el package from melpa
(general-define-key
 :keymaps '(normal insert emacs)
 :prefix "SPC"
 :non-normal-prefix "M-SPC"
 "b" '(:ignore t :which-key "buffers")
 "f" '(:ignore t :which-key "files")
 "n" '(:ignore t :which-key "neotree")
 "g" '(:ignore t :which-key "script")
 "c" '(:ignore t :which-key "company")
 "u" '(:ignore t :which-key "unix")
 "m" '(:ignore t :which-key "mark")
 "h" '(:ignore t :which-key "helm-key")
 "h o" 'helm-occur
 "c i" 'toggle-company-english-helper
 "n t" 'neotree-toggle
 "n d" 'neotree-dir
 "f e d" 'open-my-init-file
 "f e o" 'quick-open-org-main-file
 "b k" 'buf-move-up
 "b j" 'buf-move-down
 "b h" 'buf-move-left
 "b l" 'buf-move-right
 "u s" 'unix-sync
 "g b" 'shell-command-on-buffer
 "g r" 'gif-record
 "m m" 'format-paragraph
 "b d" 'kill-buffer-and-window)

;; enable super key.
(general-define-key
 :prefix "s-c"
 "a" 'org-agenda
 "c" 'org-capture
 )

(general-define-key
 :prefix "H-<return>"
 :keymaps '(yas-minor-mode-map normal insert emacs)
 "i" 'sdcv-search-input+
 "RET" 'insert-translated-name-insert
 "SPC" 'yas-maybe-expand
 "y" #'yas-expand
 )

;;(define-key yas-minor-mode-map (kbd "C-c y") #'yas-expand)
;; (global-set-key (kbd "H-<return>") 'insert-translated-name-insert) ; H is for hyper(global-set-key (kbd "s-b") 'ba)


;; define ace window keybinding
;; cause me use evil-mode,so don't need ace jump.

(general-define-key
 :keymaps '(normal)
 :prefix "C-w"
 "C-w" 'ace-window
 "s" 'ace-swap-window
 "d" 'ace-delete-window
 "o" 'ace-delete-other-windows
 "v" (lambda ()
       (interactive)
       (split-window-right)
       (windmove-right))
 "x" (lambda ()
       (interactive)
       (split-window-below)
       (windmove-down))
 "h" 'windmove-left
 "j" 'windmove-down
 "k" 'windmove-up
 "l" 'windmove-right
 )
;; Evil:1 ends here

;; [[file:~/.emacs.d/init.org::*Evil terminal cursor setting][Evil terminal cursor setting:1]]
(unless (display-graphic-p)
  (require 'evil-terminal-cursor-changer)
  (evil-terminal-cursor-changer-activate) ; or (etcc-on)
  )
(setq evil-motion-state-cursor 'box)  ; █
(setq evil-visual-state-cursor 'box)  ; █
(setq evil-normal-state-cursor 'box)  ; █
(setq evil-insert-state-cursor 'bar)  ; ⎸
(setq evil-emacs-state-cursor  'hbar) ; _
;; Evil terminal cursor setting:1 ends here

;; [[file:~/.emacs.d/init.org::*Helm][Helm:1]]
(with-eval-after-load
    (require 'helm)
  (helm-mode 1)
  (require 'helm-config)

  (global-set-key (kbd "M-x") #'helm-M-x)
  (global-set-key (kbd "s-f") #'helm-projectile-ag)
  (global-set-key (kbd "s-t") #'helm-projectile-find-file-dwim)

  (setq helm-M-x-fuzzy-match t) ;; optional fuzzy matching for helm-M-x

  (global-set-key (kbd "M-y") 'helm-show-kill-ring)

  (global-set-key (kbd "C-x b") 'helm-mini)

  (setq helm-buffers-fuzzy-matching t
        helm-recentf-fuzzy-match    t)

  (global-set-key (kbd "C-x C-f") 'helm-find-files)

  (setq helm-semantic-fuzzy-match t
        helm-imenu-fuzzy-match    t)

  ;; if you want from emacs history command jump to eamcs commands,please use `C-o`
  ;; ref link: https://emacs.stackexchange.com/questions/18173/how-to-jump-from-emacs-command-history-to-emacs-commands-in-helm

  ;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
  ;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
  ;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.

  (global-set-key (kbd "C-c h") 'helm-command-prefix)

  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action

  (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal

  (define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

  (define-key helm-map (kbd "C-j") 'helm-next-line)
  (define-key helm-map (kbd "C-k") 'helm-previous-line)
  (define-key helm-map (kbd "C-h") 'helm-next-source)
  (define-key helm-map (kbd "C-S-h") 'describe-key)
  (define-key helm-map (kbd "C-l") (kbd "RET"))
  (define-key helm-map [escape] 'helm-keyboard-quit)
  (dolist (keymap (list helm-find-files-map helm-read-file-map))
    (define-key keymap (kbd "C-l") 'helm-execute-persistent-action)
    (define-key keymap (kbd "C-h") 'helm-find-files-up-one-level)
    (define-key keymap (kbd "C-S-h") 'describe-key))

  (when (executable-find "curl")
    (setq helm-google-suggest-use-curl-p t))

  (setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
        helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
        helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
        helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
        helm-ff-file-name-history-use-recentf t
        helm-echo-input-in-header-line t)

  (setq helm-autoresize-max-height 0)

  (setq helm-autoresize-min-height 40)

  ;; fix helm error
  ;; (defun evil//hide-cursor-in-helm-buffer()
  ;;   "hide the cursor in helm buffer"
  ;;   (with-helm-buffer
  ;;     (setq cursor-in-non-selected-windows nil)))

  ;; (add-hook 'helm-after-initialize-hook
  ;;        'evil//hide-cursor-in-helm-buffer)

  (helm-autoresize-mode 1)
  )
;; Helm:1 ends here

;; [[file:~/.emacs.d/init.org::*web-mode][web-mode:1]]
(require 'web-mode)

;; support html and more web type language
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.xml?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.scss?\\'" . web-mode))

;; customize
(defun my-web-mode-hook()
  "Hooks for web mode"
  (setq web-mode-markup-indent-offset 2)  ;; html element offset identation
  (setq web-mode-css-at-rules 2) ;; css element offset identation
  (setq web-mode-code-indent-offset 2) ;; script/code offset indentation
  ;; other code script offset identation

  )

(add-hook 'web-mode 'my-web-mode-hook)

;; Add svelte mode
(add-to-list 'load-path "~/.emacs.d/lisp/utils/web/sveltejs/")
(require 'svelte-mode)
(customize-set-variable 'svelte-basic-offset 2)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . svelte-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . svelte-mode))

;; Add Html folder
                                        ;(add-to-list 'load-path "~/.emacs.d/lisp/utils/web/html/html-fold/")
                                        ;(autoload 'html-fold-mode "html-fold" "Minor mode for hiding and revealing elements." t)
                                        ;(add-hook 'html-mode-hook 'html-fold-mode)
;; web-mode:1 ends here

;; [[file:~/.emacs.d/init.org::*web-beautify][web-beautify:1]]
(eval-after-load 'js2-mode
  '(add-hook 'js2-mode-hook
             (lambda ()
               (add-hook 'before-save-hook 'web-beautify-js-buffer t t))))

(eval-after-load 'js-mode
  '(add-hook 'js2-mode-hook
             (lambda ()
               (add-hook 'before-save-hook 'web-beautify-js-buffer t t))))

(eval-after-load 'json-mode
  '(add-hook 'js2-mode-hook
             (lambda ()
               (add-hook 'before-save-hook 'web-beautify-js-buffer t t))))

(eval-after-load 'web-mode
  '(add-hook 'js2-mode-hook
             (lambda ()
               (add-hook 'before-save-hook 'web-beautify-js-buffer t t))))

(eval-after-load 'css-mode
  '(add-hook 'js2-mode-hook
             (lambda ()
               (add-hook 'before-save-hook 'web-beautify-js-buffer t t))))
;; web-beautify:1 ends here

;; [[file:~/.emacs.d/init.org::*company][company:1]]
(require 'company)
(require 'company-go)
;; use company-mode in all buffers
(add-hook 'after-init-hook 'global-company-mode)

;; configure java script
;; (add-to-list 'load-path "~/.emacs.d/lisp/utils/company/company-tern/company-tern.el")
;;(add-hook 'js-mode-hook
;;		  (lambda()
;;			(setq company-backends '(company-tern))))

;; (add-hook 'js-mode-hook
;;                '(lambda ()
;;                       (setq-local company-backends '((company-web company-css company-tern :with company-yasnippet)))))


;; (add-to-list 'company-backends 'company-tern)
(setq company-tern-meta-as-single-line t)
(setq company-tooltip-align-annotations t)


;;; company web mode configuration

;; load HTML|jade|slim backend
(require 'company-web-html)
(require 'company-web-jade)
(require 'company-web-slim)
(define-key web-mode-map (kbd "TAB") 'company-web-html)

;; (setq company-minimum-prefix-length 0) ; WARNING, probably you will get perfomance issue if min len is 0!
(setq company-tooltip-limit 20)                      ; bigger popup window
(setq company-tooltip-align-annotations 't)          ; align annotations to the right tooltip border
(setq company-idle-delay .3)                         ; decrease delay before autocompletion popup shows
(setq company-echo-delay 0)							 ; remove annoying blinking
(setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing
;; (global-set-key (kbd "C-c /") 'company-files)        ; Force complete file names on "C-c /" key

;; Only use company-mode with company-web-html in web-mode
(add-hook 'web-mode-hook
          (lambda ()
            (set (make-local-variable 'company-backends)'(company-web-html))))

;;; shell mode configuration with company mode

;; make URL clickable
(add-hook 'shell-mode-hook (lambda () (goto-address-mode)))
;; make file path clickable
(add-hook 'shell-mode-hook 'compilation-shell-minor-mode)
;; active shell mode
(add-hook 'shell-mode-hook #'company-mode)
(define-key shell-mode-map (kbd "TAB") #'company-manual-begin)
;; company:1 ends here

;; [[file:~/.emacs.d/init.org::*rainbow delimiters][rainbow delimiters:1]]
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
;; rainbow delimiters:1 ends here

;; [[file:~/.emacs.d/init.org::*yasnippet][yasnippet:1]]
(require 'yasnippet)
;; (setq yas-snippet-dirs
;;              '(
;;                "~/.emacs.d/snippets/"		;personal snippers.
;;                "~/.emacs.d/elpa/yasnippet-snippets-20200802.1658/snippets/" ;extra package collection.
;;                )
;;              )

;; global enable `aggressive-indent-mode'
;; (global-aggressive-indent-mode 1)

(yas-minor-mode 1)
(add-hook 'prog-mode-hook #'yas-minor-mode)
(yas-global-mode 1)

(yas-reload-all)
(require 'yasnippet-snippets)
;; 将html mode 排除在外
;; (add-to-list 'aggressive-indent-excluded-modes 'html-mode)

;; 在ORG MODE里面 yas-expand 巨恶心，只能取消下。
;; https://joaotavora.github.io/yasnippet/snippet-expansion.html#org87a6f68
;; (define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map [(tab)] nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)

(define-key org-mode-map (kbd "<backtab>") nil)

(defun revolt/company-to-yasnippet ()
  (interactive)
  (company-abort)
  (call-interactively 'company-yasnippet))

(bind-key "<backtab>" 'revolt/company-to-yasnippet company-active-map)
(bind-key "<backtab>" 'company-yasnippet)

;; Bind `SPC' to `yas-expand' when snippet expansion available (it
;; will still call `self-insert-command' otherwise).
;;(define-key yas-minor-mode-map (kbd "SPC") yas-maybe-expand)
;; Bind `C-c y' to `yas-expand' ONLY.

;;(define-key yas-minor-mode-map (kbd "C-c y") #'yas-expand)
;; yasnippet:1 ends here

;; [[file:~/.emacs.d/init.org::*flyspell][flyspell:1]]
;; hunspell dict in here download: https://extensions.libreoffice.org/en/extensions/show/english-dictionaries
;; https://tex.stackexchange.com/questions/313370/installing-a-dictionary-files-extension-oxt
;; uzip oxt file is OK .

;; Plain text mode
(dolist (hook '(text-mode-hook org-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))

;; log mode
(dolist (hook '(change-log-mode-hook log-edit-mode-hook))
  (add-hook hook (lambda () (flyspell-mode -1))))

;; code comment scene
(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (flyspell-prog-mode)
            ))

;; use hunspell
(setq ispell-program-name (executable-find "hunspell")
      ispell-dictionary "en_US")

;; key binding `helm-flyspell-correct' auto fix word error
(define-key org-mode-map (kbd "C-'") nil)

;; set helm flysepll dictionary
(define-key flyspell-mode-map (kbd "C-'") 'helm-flyspell-correct)

;;; TODO: how to removing words form the hunspell directory

;;; how to running flyspell on any type of buffer?
;; =M-x flyspell-buffer=
;; flyspell:1 ends here

;; [[file:~/.emacs.d/init.org::*circe][circe:1]]
(require 'circe)
(setq circe-network-options
      '(("Freenode"
         :tls t
         :nick "revolt"
         :sasl-username "mrrevolt"
         :sasl-password "pz621z521wodejia"
         :channels ("#emacs")
         )))
;; circe:1 ends here

;; [[file:~/.emacs.d/init.org::*real-save-mode][real-save-mode:1]]
(with-eval-after-load 'real-auto-save
  (require 'real-auto-save)
  (add-hook 'org-mode-hook 'real-auto-save-mode)
  (add-hook 'markdown-mode-hook 'real-auto-save-mode)
  (add-hook 'shell-mode-hook 'real-auto-save-mode)

  (setq real-auto-save-mode t)
  (setq real-auto-save-interval 1.2)	; Auto save interval is 2 secodes

  ;; (setq real-auto-save-use-idle-timer 2)
  )
;; real-save-mode:1 ends here

;; [[file:~/.emacs.d/init.org::*pdf tools][pdf tools:1]]
(pdf-tools-install)
(defun my/org-ref-open-pdf-at-point ()
  "Open the pdf for bibtex key under point if it exists."
  (interactive)
  (let* ((results (org-ref-get-bibtex-key-and-file))
         (key (car results))
         (pdf-file (car (bibtex-completion-find-pdf key))))
    (if (file-exists-p pdf-file)
        (funcall bibtex-completion-pdf-open-function pdf-file)
      (message "No PDF found for %s" key))))
;; pdf tools:1 ends here

;; [[file:~/.emacs.d/init.org::*emmet && mode indent][emmet && mode indent:1]]
(require 'emmet-mode)

;; you should know how to use html abbreviations and css abbreviations
;; https://github.com/smihica/emmet#html
;; https://github.com/smihica/emmet#css

(add-hook 'html-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook 'emmet-mode)
(add-hook 'web-mode-hook 'emmet-mode)

;; set indent 2 space.
(add-hook 'emmet-mode-hook (lambda () (setq emmet-indentation 2)))
(setq emmet-move-cursor-between-quotes t)

;; unset C-<return> key, rebind to PYIM input method pinyin convert
(define-key emmet-mode-keymap (kbd "C-<return>") nil)
;; (global-set-key (kbd "C-<return>") 'pyim-convert-code-at-point)

(define-key emmet-mode-keymap (kbd "C-j") 'emmet-expand-line)
;; (global-set-key (kbd "<tab>") 'emmet-expand-line)
;; emmet && mode indent:1 ends here

;; [[file:~/.emacs.d/init.org::*neotree][neotree:1]]
(require 'neotree)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
;; neotree:1 ends here

;; [[file:~/.emacs.d/init.org::*posframe][posframe:1]]
(require 'posframe)
;; posframe:1 ends here

;; [[file:~/.emacs.d/init.org::*all-the-icon][all-the-icon:1]]
(require 'all-the-icons)
;; all-the-icon:1 ends here

;; [[file:~/.emacs.d/init.org::*engine][engine:1]]
(require 'engine-mode)
(engine-mode t)

;; change your defalut browser
(setq engine/browser-function 'eww-browse-url)

(defengine github
  "https://github.com/search?ref=simplesearch&q=%s")

(defengine duckduckgo
  "https://duckduckgo.com/?q=%"
  :keybinding "d"
  :browser 'eww-browse-url)

(defengine google
  "https://google.com/?q=%"
  :keybinding "g")
;; engine:1 ends here

;; [[file:~/.emacs.d/init.org::*expand region][expand region:1]]
(setq alphabet-start "abc def")
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)
;; expand region:1 ends here

;; [[file:~/.emacs.d/init.org::*pyim][pyim:1]]
(require 'pyim)
;; (require 'pyim-basedict)
;; (pyim-basedict-enable)

;; load great dict
;; ref link: https://github.com/tumashu/pyim-greatdict
(add-to-list 'load-path  "~/.emacs.d/.utils/dict/pyim-greatdict/")

;; use big dict
(require 'pyim-greatdict)
(pyim-greatdict-enable)

(setq default-input-method "pyim")
(setq pyim-page-tooltip 'posframe)
(setq pyim-page-length 5)

;; 双拼模式
(setq pyim-default-scheme 'quanpin)

;; enable pinyin search function
;; (pyim-isearch-mode 1)

;; (global-set-key (kbd "SPC-SPC") 'toggle-input-method)

;; 直接使用半角符号。
;; Optinals parameters: yes/no/auto
(setq pyim-punctuation-translate-p 'no)

;; 中英文切换
(setq-default pyim-english-input-switch-functions
              '(pyim-probe-dynamic-english
                pyim-probe-isearch-mode
                pyim-probe-program-mode
                pyim-probe-org-structure-template))

(setq-default pyim-punctuation-half-width-functions
              '(pyim-probe-punctuation-line-beginning
                pyim-probe-punctuation-after-punctuation))

;; https://emacs.stackexchange.com/questions/1020/problems-with-keybindings-when-using-terminal
;; So sorry, I want to bind `<M-<return>' give 'pyim-convert-code-at-point,but not working in xterm.
;; you know, xterm M-RET is fullscreen, i already ban it,but still not working.So i guess remove xterm M-RET key bind.
(define-key org-mode-map (kbd "C-<return>") nil)
(global-set-key (kbd "C-<return>") 'pyim-convert-code-at-point)

;; enable guess word

;; import outside pyim dict
;; (setq pyim-dicts
;;       '(
;;      (:name "dict1" :file "~/.emacs.d/dict/scel2pyim/pyim-dict/pyim-bigdict.pyim")
;;      (:name "dict2" :file "~/.emacs.d/dict/scel2pyim/pyim-dict/computer_all_word.pyim")
;;      (:name "dict3" :file "~/.emacs.d/dict/scel2pyim/pyim-dict/programming.pyim")
;;      ))

;; When you start emacs auto load thesaurus
(add-hook 'emacs-startup-hook
          #'(lambda() (pyim-restart-1 t)))
;; pyim:1 ends here

;; [[file:~/.emacs.d/init.org::*command-log][command-log:1]]
(with-eval-after-load
    (require 'command-log-mode)
  ;; (add-hook 'emacs-startup-hook 'command-log-mode-hook)

  (defun enable-command-log()
    (interactive)
    (command-log-mode 1)
    (clm/toggle-command-log-buffer))
  (global-set-key (kbd "C-c o") 'enable-command-log)
  )
;; command-log:1 ends here

;; [[file:~/.emacs.d/init.org::*better-default][better-default:1]]
(require 'better-defaults)
;; better-default:1 ends here

;; [[file:~/.emacs.d/init.org::*projectile][projectile:1]]
(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
;; projectile:1 ends here

;; [[file:~/.emacs.d/init.org::*mode line][mode line:1]]
(require 'doom-modeline)
(require 'all-the-icons)
(setq doom-modeline-minor-modes t)
(setq doom-modeline-indent-info t)
(setq inhibit-compacting-font-caches t)
(doom-modeline-mode 1)
;; mode line:1 ends here

;; [[file:~/.emacs.d/init.org::*ox-hugo][ox-hugo:1]]
(with-eval-after-load 'ox
  (require 'ox-hugo))
;; ox-hugo:1 ends here

;; [[file:~/.emacs.d/init.org::*golden ration window][golden ration window:1]]
;; -*-Emacs-lisp-*-
(require 'golden-ratio)
(golden-ratio-mode 1)
(require 'ace-window)
;; golden ration window:1 ends here

;; [[file:~/.emacs.d/init.org::*flycheck][flycheck:1]]
(with-eval-after-load 'flycheck
  (require 'flycheck)
  (add-hook 'sh-mode-hook 'flycheck-mode)
  )
;; flycheck:1 ends here

;; [[file:~/.emacs.d/init.org::*yaml][yaml:1]]
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
(defun org-babel-execute:yaml (body params) body)
;; yaml:1 ends here

;; [[file:~/.emacs.d/init.org::*google translate][google translate:1]]
;; Emacs google translate
;; ref link
;; https://github.com/atykhonov/google-translate

;;; Code:
(require 'google-translate)
(require 'google-translate-smooth-ui)
(global-set-key "\C-ct" 'google-translate-smooth-translate)

;; (with-eval-after-load 'google-translate
;;   (require 'google-translate)
;;   (require 'google-translate-default-ui)
;;   (global-set-key "\C-ct" 'google-translate-at-point)
;;   (global-set-key "\C-cT" 'google-translate-query-translate)
;;   )

;; fix ttk error
(defun google-translate--search-tkk ()
  "Get the Token-Key from the page buffer."
  (let (downloaded)
    (setq downloaded (shell-command-to-string "curl -s --user-agent 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_2) AppleWebKit/600.3.18 (KHTML, like Gecko) Version/8.0.3 Safari/600.3.18' 'https://translate.google.com' | sed 's/,/\\n,/g' | grep ',tkk'"))
    (print downloaded)
    (with-temp-buffer (insert downloaded)
                      (goto-char 0)
                      (re-search-forward ",tkk:'\\([0-9]+\\)\\.\\([0-9]+\\)")
                      (list (string-to-number (match-string 1))
                            (string-to-number (match-string 2))))))
;; google translate:1 ends here

;; [[file:~/.emacs.d/init.org::*Emojify][Emojify:1]]
(add-hook 'after-init-hook #'global-emojify-mode)
;; Emojify:1 ends here

;; [[file:~/.emacs.d/init.org::*Undo-tree][Undo-tree:1]]
(global-undo-tree-mode)
;; Undo-tree:1 ends here

;; [[file:~/.emacs.d/init.org::*highlight-symbol][highlight-symbol:1]]
(require 'highlight-symbol)
(global-set-key [(control f3)] 'highlight-symbol)
(global-set-key [f3] 'highlight-symbol-next)
(global-set-key [(shift f3)] 'highlight-symbol-prev)
(global-set-key [(meta f3)] 'highlight-symbol-query-replace)
;; highlight-symbol:1 ends here

;; [[file:~/.emacs.d/init.org::*Vterm][Vterm:1]]
(require 'vterm)
;; Vterm:1 ends here
