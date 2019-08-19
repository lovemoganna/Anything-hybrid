; fast open configuration file
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

;; load recent file
(require 'recentf)
(recentf-mode t)
(setq recentf-max-menu-item 10)

(provide 'init-customization)
