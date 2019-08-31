(add-to-list 'load-path "~/.emacs.d/lisp/ui")
(add-to-list 'load-path "~/.emacs.d/lisp/dictionary")
(add-to-list 'load-path "~/.emacs.d/lisp/evil")
(require 'init-ui)
(require 'doom-modeline-config)
;; fast open configuration file
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

;; load recent file
(require 'recentf)
(recentf-mode t)
(setq recentf-max-menu-item 10)

;; helm setting
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


(helm-mode 1)

;; active helm grep,just use C-s will have pattern,just like helm-occur
(when (executable-find "ack-grep")
  (setq helm-grep-default-command "ack-grep -Hn --no-group --no-color %e %p %f"
        helm-grep-default-recurse-command "ack-grep -H --no-group --no-color %e %p %f"))

;; helm eshell history
(require 'helm-eshell)

(add-hook 'eshell-mode-hook
          #'(lambda ()
              (define-key eshell-mode-map (kbd "C-c C-l")  'helm-eshell-history)))

(require 'init-dictionary)
(require 'init-evil)

;; ace-jump
(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

(provide 'init-customization)
