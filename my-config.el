(add-to-list 'load-path "~/.emacs.d/lisp/")

;; Package Management
;; ----------------------------------------------------------------------------------------------------

(require 'init-packages)
(require 'init-major-mode)
(require 'init-ui)
(require 'init-org)
(require 'init-keybindings)
(require 'init-customization)
(require 'init-better-default)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("a2cde79e4cc8dc9a03e7d9a42fabf8928720d420034b66aecc5b665bbf05d4e9" default)))
 '(evil-auto-indent t)
 '(evil-mode t)
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(package-selected-packages (quote (company evil))))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'helm-config)
(helm-mode 1)

(set-language-environment "UTF-8")
