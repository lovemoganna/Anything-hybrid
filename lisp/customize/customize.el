;; 关闭工具栏，Tool-Bar-Mode 即为一个 Minor Mode
(tool-bar-mode -1)
(menu-bar-mode -1)
;; 关闭文件滑动控件
(scroll-bar-mode -1)

;; 显示行号
;; (global-linum-mode 1)

;; 关闭启动帮助画面
(setq inhibit-splash-screen t
      initial-scratch-message ";;--------------------  为追求极致的力量,成为敏捷有力的执行者-
;;--------------------  -
;;--------------------  虚拟生活,应该掌握毁灭与创造的能力.毁灭是面临屠杀时,.-
;;--------------------  创造是抱有好奇心,探索美好与糟糕.- \n\n"
      ;; initial-major-mode 'org-mode
      )


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
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; UTF-8 as default encoding
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8-unix)

;; hacks to reduce the startup time.
(setq gc-cons-threshold (expt 2 24))
(setq load-prefer-newer t)

;; personal information
;; (setq user-full-name "revolt")

;; import customzie path
(add-to-list 'load-path "~/.emacs.d/lisp/customize")

;; face setting
(org-babel-load-file "~/.emacs.d/lisp/customize/faces/face")

;; font setting 
(require 'init-font "./font/init-font.el")

;; global themes monokai
(require 'init-global-themes "./themes/init-global-themes")

;; keybinding
(require 'init-key-binding "./keybinding/init-key-binding")

;; browser
(require 'init-firefox-browser "./browser/init-firefox-browser")

;; latex support
(require 'init-latex "./latex/init-latex")

;; evil terminal cursor setting
(require 'init-terminal "./terminal/init-terminal")
