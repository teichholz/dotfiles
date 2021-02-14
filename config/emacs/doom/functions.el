;;; ~/.doom.d/functions.el -*- lexical-binding: t; -*-





(require 'dash)

(defun own/run-compiler (files)
  (interactive "fArgumente: ")
  (let* ((dir "/home/tim/sciebo/Dokumente/Projektarbeit/Scheme-Compiler/")
         (prog "checkprogs.sh ")
         (dirp (f-directory-p files))
         (files (if dirp
                    (f-files files)
                  (list files))))
    ;; shell-command expects the arguments to be relative to its program
    (shell-command
     (concat dir prog
             (mapconcat (lambda (file) (f-relative file dir))
                        files
                        " ")))))
(defun own/ae ()
  (interactive)
  (insert "ä"))

(defun own/oe ()
  (interactive)
  (insert "ö"))

(defun own/ue ()
  (interactive)
  (insert "ü"))

(defun own/ss ()
  (interactive)
  (insert "ß"))
