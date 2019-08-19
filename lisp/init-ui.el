;; load customize themes
(load-theme 'monokai 1)

;;highlight current line 
(global-hl-line-mode 1)

;;show line numbers
(global-linum-mode t)

;; Close Tool Bar
(tool-bar-mode -1)

;;Close startup help screen
(setq inhibit-splash-screen 1)

;; Set Cursor Style
(setq-default cursor-type 'bar)

;; Close Scroll bar
(scroll-bar-mode 1)


(provide 'init-ui)
