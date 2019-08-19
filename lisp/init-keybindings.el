;; fast open agenda
(global-set-key (kbd "C-c a") 'org-agenda)

;; give the function bind a key
(global-set-key (kbd "<f2>") 'open-init-file)

(global-set-key (kbd "C-x C-r") 'recentf-open-files)

(global-set-key (kbd "C-M-\\") 'indent-region-or-buffer)

(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)

(provide 'init-keybindings)
