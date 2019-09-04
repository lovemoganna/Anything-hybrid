;;; init-ui.el --- doom theme configuration:

;;; Commentary:

;; load customize themes
;; (load-theme 'monokai 1)


;;; Code:

;; fix the icon missing
;; M-x all-the-icons-install-fonts
;;highlight current line
(require 'doom-themes)

;;; Global settings (defaults):

; if nil, bold is universally disabled
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

;;Close startup help screen
(setq inhibit-splash-screen 1)

;; Set Cursor Style
(setq-default cursor-type 'bar)

;; Close Scroll bar
(scroll-bar-mode 1)

;;; init-ui.el ends here
(provide 'init-ui)
