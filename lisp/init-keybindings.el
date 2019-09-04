;; fast open agenda
(global-set-key (kbd "C-c a") 'org-agenda)

;; give the function bind a key
(global-set-key (kbd "<f2>") 'open-init-file)

(global-set-key (kbd "C-x C-r") 'recentf-open-files)

(global-set-key (kbd "C-M-\\") 'indent-region-or-buffer)

;; helm key bind
(require 'helm)
(require 'helm-config)

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

;; youdao dictionary voice at point
(global-set-key (kbd "C-c v") 'youdao-dictionary-play-voice-at-point)
(require 'helm-eshell)

(add-hook 'eshell-mode-hook
          #'(lambda ()
              (define-key eshell-mode-map (kbd "C-c C-l")  'helm-eshell-history)))

(provide 'init-keybindings)
