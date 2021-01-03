;;; ~/.doom.d/dash-at-point.el -*- lexical-binding: t; -*-

(def-package! dash-at-point
  :config
  (add-to-list 'dash-at-point-mode-alist '(web-mode . "html, css"))
  (add-to-list 'dash-at-point-mode-alist '(racket-mode . "racket"))
  (add-to-list 'dash-at-point-mode-alist '(python-mode . "python")))
