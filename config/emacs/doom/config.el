;; gets loaded after any modules
;; (fset 'battery-update #'ignore)

(load! "./vars.el")
;; (load! "./dash-at-point.el")
;;(load! "./winum.el")
;; (load! "./lispyville.el")
;; (load! "./packages/python-lsp-ms.el")
;;(load! "./hydras.el")
(load! "./keybindings.el")
(load! "./functions.el")
;;(load! "./documentation.el")
;; (load! "./packages/llvm-mode.el")


;; (use-package! symbol-overlay)
;; (use-package! dired-filter)
;; (use-package! dired-narrow)
;; (use-package! dired-subtree)
;; (use-package! dired-sidebar)
;; (use-package! dired-launch)
;; (use-package! org-roam-bibtex
;;   :hook (org-roam-mode . org-roam-bibtex-mode)
;;   :bind (:map org-mode-map
;;           (("C-c n a" . orb-note-actions))))
;; (use-package! helm-bibtex
;;   :config
;;   (setq bibtex-completion-bibliography
;;         (concat org-directory "/bib/bibliography.bib")))

;; (use-package! org-ref
;;   :config
;;   (setq
;;    org-ref-bibliography-notes (concat org-directory "/bib/notes.org")
;;    org-ref-default-bibliography bibtex-completion-bibliography
;;    org-ref-pdf-directory (concat org-directory "/bib/pdfs/")))
;; (use-package! bibtex-completion
;;   :config
;;   (setq bibtex-completion-library-path (list (concat org-directory "/bib/pdfs/"))
;;         bibtex-completion-pdf-field "file"))
;; (use-package! flymake-hlint
;;   :config
;;   (add-hook 'haskell-mode-hook 'flymake-hlint-load))
;; (use-package! hindent
;;   :config
;;   (add-hook 'haskell-mode-hook 'hindent-mode))

(setq deft-directory org-roam-directory)
(setq reftex-default-bibliography bibtex-completion-bibliography)
(setq +latex-viewers '(pdf-tools))

(add-hook! eshell-mode
  (company-mode 1))

;; which-key
(after! which-key
  (setq which-key-idle-delay 0.1))

;; Paredit mode
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)
(add-hook 'clojure-mode-hook           #'enable-paredit-mode)



(add-hook 'company-completion-started-hook 'ans/set-company-maps)
(add-hook 'company-completion-finished-hook 'ans/unset-company-maps)
(add-hook 'company-completion-cancelled-hook 'ans/unset-company-maps)

(defun ans/unset-company-maps (&rest unused)
"Set default mappings (outside of company).
Arguments (UNUSED) are ignored."
(general-def
:states 'insert
:keymaps 'override
"<up>" nil
"<down>" nil
"C-j" nil
"C-k" nil
"C-h" nil
"C-s" nil
"RET" nil
[return] nil))

(defun ans/set-company-maps (&rest unused)
"Set maps for when you're inside company completion.
Arguments (UNUSED) are ignored."
(general-def
:states 'insert
:keymaps 'override
"<down>" 'company-select-next
"<up>" 'company-select-previous
"C-j" 'company-select-next
"C-h" 'company-show-doc-buffer
"C-k" 'company-select-previous
"C-s" 'company-filter-candidates
"RET" 'company-complete
[return] 'company-complete))

(setq rustic-lsp-server 'rust-analyzer)
(setq lsp-keymap-prefix "C-l")
(setq lsp-ui-doc-max-height 150)
(setq lsp-ui-doc-max-width 150)

(eval-after-load "tex"
  '(setcdr (assoc "LaTeX" TeX-command-list)
          '("%`%l%(mode) -shell-escape%' %t"
          TeX-run-TeX nil (latex-mode doctex-mode) :help "Run LaTeX")
    ))

(setq utop-command "opam config exec -- dune utop . -- -emacs")
;; (after! lsp-python-ms
;;   (set-lsp-priority! 'mspyls 1))

(use-package lsp-haskell
  :ensure t
  :config
  (setq lsp-haskell-process-path-hie "haskell-language-server-wrapper")
  ;; Comment/uncomment this line to see interactions between lsp client/server.
  ;;(setq lsp-log-io t)
  )

(after! evil
  (require 'evil-textobj-anyblock)
  (evil-define-text-object my-evil-textobj-anyblock-inner-quote
    (count &optional beg end type)
    "Select the closest outer quote."
    (let ((evil-textobj-anyblock-blocks
           '(("'" . "'")
             ("\"" . "\"")
             ("`" . "`")
             ("“" . "”"))))
      (evil-textobj-anyblock--make-textobj beg end type count nil)))

  (evil-define-text-object my-evil-textobj-anyblock-a-quote
    (count &optional beg end type)
    "Select the closest outer quote."
    (let ((evil-textobj-anyblock-blocks
           '(("'" . "'")
             ("\"" . "\"")
             ("`" . "`")
             ("“" . "”"))))
      (evil-textobj-anyblock--make-textobj beg end type count t)))

  (define-key evil-inner-text-objects-map "q" 'my-evil-textobj-anyblock-inner-quote)
  (define-key evil-outer-text-objects-map "q" 'my-evil-textobj-anyblock-a-quote))

(setq +lookup-provider-url-alist (cons '("Hoogle" "https://hoogle.haskell.org/?hoogle=%s") +lookup-provider-url-alist))
