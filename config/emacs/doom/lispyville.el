;;; ~/.doom.d/lispyville.el -*- lexical-binding: t; -*-


(add-hook! lisp-mode #'lispy-mode)
(after! lispyville
  (lispyville-set-key-theme
   '((operators normal)
     (c-w normal)
     (prettify insert normal)
     (atom-movement normal visual)
     slurp/barf-lispy
     (wrap normal insert)
     (text-objects normal)
     additional
     (additional-motions normal)
     additional-insert
     (additional-wrap normal insert)
     (escape insert))))
