;; 关闭工具栏，Tool-Bar-Mode 即为一个 Minor Mode
(tool-bar-mode -1)

;; 关闭文件滑动控件
(scroll-bar-mode -1)

;; 显示行号
;;(global-linum-mode 1)

;; 关闭启动帮助画面
(setq inhibit-splash-screen 1)

; 开启全局 Company 补全
(global-company-mode 1)

;; different state cursor form
(setq-default cursor-type 'bar)

;; simple request
(fset 'yes-or-no-p 'y-or-n-p)

(display-time)

;; 高亮显示拷贝的区域
(transient-mark-mode t)

;; 显示匹配的括号
(show-paren-mode t)

;; disable create bak file
(setq-default make-backup-files nil)

;; 括号自动补全
(electric-pair-mode 1)

;; auto fill mode
(add-hook 'text-mode-hook 'turn-on-auto-fill)
;; import customzie path
(add-to-list 'load-path "~/.emacs.d/lisp/customize")

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
(provide 'customize)

