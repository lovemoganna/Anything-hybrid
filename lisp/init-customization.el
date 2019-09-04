;;; CostomizePackage --- Summary:
;;; Commentary:

;;; Code:
(add-to-list 'load-path "~/.emacs.d/lisp/ui")
(add-to-list 'load-path "~/.emacs.d/lisp/dictionary")
(add-to-list 'load-path "~/.emacs.d/lisp/evil")

(require 'init-ui)

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

(require 'init-dictionary)
(require 'init-evil)

;; ace-jump
(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;; use eval-in-repl
(require 'eval-in-repl)
;; Place REPL on the left of the script window when spliting
(setq eir-repl-placement 'left)
;; ielm support
(require 'eval-in-repl-ielm)
;; Evaluation expression in the current buffer.
(setq eir-ielm-eval-in-current-buffer t)
;; for .el files
(define-key emacs-lisp-mode-map (kbd "<C-return>") 'eir-eval-in-ielm)
;; for *scratch*
(define-key lisp-interaction-mode-map (kbd "<C-return>") 'eir-eval-in-ielm)
;; for M-x info
(define-key Info-mode-map (kbd "<C-return>") 'eir-eval-in-ielm)

;; use flycheck
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))
;; use yasnippet
(use-package yasnippet
  :init
  :config (yas-global-mode 1))

;; config org-babel
(eval-after-load 'org
  (lambda()
    (require 'ob-python)
    (require 'ob-org)
    ))

;; active elpy for python
(use-package elpy
  :ensure
  :init
  (elpy-enable))

;; use py_autopep8

(require 'py-autopep8)
(add-hook 'python-mode-hook 'py-autopep8-enable-on-save)

;;; init-customization.el ends here
(provide 'init-customization)
