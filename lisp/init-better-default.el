;; Open Company for Automatic completion
(global-company-mode 1)

;; Aginst make backup file
(setq make-backup-files nil)

;; Set Screen Max when emacs startup
(setq initial-frame-alist '((fullscreen . maximized)))

;;replace your selected content
(delete-selection-mode 1)

;; highlite special words
(defun highLite-it()
  "HighLight certain lines."
  (interactive)
  (if (equal "log" (file-name-extension (buffer-file-name)))
      (progn
	(highlight-lines-matching-regexp "ERROR:" 'hi-red-b)
	(highlight-lines-matching-regexp "NOTE:" 'hi-blue))))

(add-hook 'find-file-hook 'highLite-it)

;; Hightlight Brackets ()[]{}
(show-paren-mode 1)

;;(progn					
;; (show-paren-mode 1)
;; (setq show-paren-style 'expression))

;; highlight brackets
;;(setq show-paren-style 'parenthesis)

;; highlight entire expression
;;(setq show-paren-style 'expression)

;; highlight brackets if visible, else entire expression
;; (setq show-paren-style 'mixed)

;; electric-pair-mode 自动补全括号
(electric-pair-mode 1)

;; make electric-pair-mode work on more brackets
(setq electric-pair-pairs
      '(
        (?\" . ?\")
        (?\{ . ?\})
	(?\< . ?\>)))

;; active evil mode
(evil-mode 1)

;; auto load outside changed file
(global-auto-revert-mode 1)

;; close you worked make bak file
(setq auto-save-default nil)

(fset 'yes-or-no-p 'y-or-n-p)

;; code indent
(defun indent-buffer()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun indent-region-or-buffer()
  (interactive)
  (save-excursion
    (if (region-active-p)
	(progn
	  (indent-region (region-beginning) (region-end))
	  (message "Indent selected region."))
      (progn
	(indent-buffer)
	(message "Indent buffer.")))))

;; abbreviation table completion 
(setq-default abbrev-mode t)
(define-abbrev-table 'global-abbrev-table '(
					    ;; me
					    ("8r" "revolt")
					    ))

;;Hippie Completion

;; use C-x C-j enter current dir list
(require 'dired-x)
(setq dired-dwim-target 1)
;; lazy loading
(put 'dired-find-alternate-file 'disabled nil)

;; 主动加载 Dired Mode
;; (require 'dired)
;; (defined-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)

;; 延迟加载
(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))

;; hidden special symbol
(defun hidden-dos-eol ()
  "Do not show ^M in files containing mixed UNIX and DOS line endings."
  (interactive)
  (unless buffer-display-table
    (setq buffer-display-table (make-display-table)))
  (aset buffer-display-table ?\^M []))

(defun remove-dos-eol ()
  "Replace DOS eolns CR LF with Unix eolns CR"
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))

(provide 'init-better-default)
