;;  helm-ff-auto-update-initial-value t
;;  helm-find-files-doc-header " (\\<helm-find-files-map>\\[helm-find-files-up-one-level]: Go up one level)"
;;  helm-display-buffer-height 50
;;  helm-display-buffer-default-height 1)




(setq tab-always-indent 'complete)

(setq company-show-numbers t)

(setq evil-escape-key-sequence "fd")

(setq doom-localleader-key ",")
(setq doom-font (font-spec :family "Iosevka Extended" :size 22))
(setq doom-theme 'doom-one)

(prefer-coding-system 'utf-8-unix)
(when (display-graphic-p)
  (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING)))

(setq display-line-numbers 'relative)
(setq lsp-ui-sideline-ignore-duplicate t)
(setq lsp-ui-sideline-enable nil)
;; (setq lsp-ui-doc-mode nil
;;       lsp-ui-doc-position 'top
;;       lsp-ui-doc-use-webkit t
;;       lsp-ui-doc-delay 2
;;       lsp-enable-symbol-highlighting nil
;;       lsp-ui-doc-max-height '25)
;; (setq lsp-eldoc-enable-hover nil)

;; TODO evtl. aendern
;; (setq company-lsp-cache-candidates 'auto)

;; (setq lsp-ui-mode-hook 'turn-off-lsp-ui-doc)
;; (after! lsp-ui
;;   (lsp-ui-doc-mode 0))


(setq evil-echo-state nil)

(setq make-backup-files t)


;; (setq lsp-python-ms-dir
;;       (expand-file-name "~/GitHub/python-language-server/output/bin/Release/"))

(setq confirm-kill-emacs nil
      confirm-kill-processes nil)

(setq dired-filter-group-saved-groups '(("default"
                                         ("PDF"
                                          (extension . "pdf"))
                                         ("LaTeX"
                                          (extension "tex" "bib"))
                                         ("Org"
                                          (extension . "org"))
                                         ("Archives"
                                          (extension "zip" "rar" "gz" "bz2" "tar"))
                                         ("Pictures"
                                          (extension "png" "jpg" "svg")))))
(setq dired-launch-default-launcher "open -a")
(setq dired-sidebar-subtree-line-prefix "__")
(setq dired-sidebar-use-term-integration t)
(setq dired-sidebar-use-custom-font t)
(setq dired-sidebar-icon-scale 1)
(setf dired-launch-extensions-map
      '(;; specify LibreOffice as the preferred application for
        ;; a Microsoft Excel file with the xslx extension
        ("xlsx" ("libreofficedev5.3"))
        ;; specify LibreOffice and Abiword as preferred applications for
        ;; an OpenDocument text file with the odt extension
        ("odt" ("libreofficedev5.3" "abiword"))
        ("pdf" ("Adobe Acrobat Reader DC"))))

;; (setenv "PKG_CONFIG_PATH" "/usr/local/lib/pkgconfig:/usr/local/Cellar/libffi/3.2.1/lib/pkgconfig")

(setq treemacs-width 25)

(setq org-directory (expand-file-name "~/doc/org"))
(setq org-default-notes-file (concat org-directory "/notes.org"))
(setq +org-code-file (concat org-directory "/code.org"))
(setq org-startup-with-inline-images t)

(after! org
  (push (list "c" "templates for code") org-capture-templates)
  (push (list "ce" "emacs snippet" 'entry (list 'file+headline +org-code-file "Emacs lisp")
              "* Elisp Snippet: %?\n  #+BEGIN_SRC emacs-lisp \n %i\n #+END_SRC\n  %a")
        org-capture-templates)
  (push (list "ca" "algorithm snippet" 'entry (list 'file+headline +org-code-file "Algorithms")
              "* Algorithm: %?\n  #+BEGIN_SRC %(symbol-value 'prog-major-mode) \n %i\n #+END_SRC\n  %a")
        org-capture-templates))

(setq org-noter-notes-window-location "Vertical"
      org-noter-doc-split-fraction '(0.8 . 0.8))

(menu-bar-mode 0)

(setq doom-scratch-buffer-major-mode t)

(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(setq enable-local-variables :all)
(setq latex-run-command "latex -shell-escape")


(setq haskell-process-type 'stack-ghci)
(setq haskell-compile-cabal-build-command "stack run")

(setq ispell-dictionary "de_DE")

(add-hook! haskell-mode
  (setq! evil-shift-width 2))
