;;; ~/.doom.d/winum.el -*- lexical-binding: t; -*-

(def-package! winum
  :init
  (setq winum-auto-setup-mode-line nil)
  (defun winum-assign-9-to-calculator-8-to-flycheck-errors ()
    (cond
     ((equal (buffer-name) "*Flycheck errors*") 8)))

  (defun winum-assign-0-to-neotree ()
    (when (string-match-p (buffer-name) ".*\\*Treemacs\\*.*") 10))
  :after evil
  :config
  (winum-mode)
  (map! :n "M-0" #'winum-select-window-0-or-10
        :n "M-1" #'winum-select-window-1
        :n "M-2" #'winum-select-window-2
        :n "M-3" #'winum-select-window-3
        :n "M-4" #'winum-select-window-4
        :n "M-5" #'winum-select-window-5
        :n "M-6" #'winum-select-window-6
        :n "M-7" #'winum-select-window-7
        :n "M-8" #'winum-select-window-8)
  (add-to-list 'winum-assign-functions #'winum-assign-9-to-calculator-8-to-flycheck-errors)
  (add-to-list 'winum-assign-functions #'winum-assign-0-to-neotree))
