;; Leichtes markieren mit Hyper m
(map! :after helm
      (:map (helm-find-files-map helm-buffer-map helm-M-x-map)
       "H-m" #'helm-toggle-visible-mark)
      ;; Universelle Argument in helm buffern
      (:map helm-map
        "C-u" #'universal-argument
        ;;"<tab>" #'helm-select-action
        )
      (:map helm-find-files-map
        "<tab>" 'helm-ff-TAB
       )

      ;; Undo Tree
      :n "U" #'undo-fu-only-redo

      ;; Hippie expand
      :i "M-e" 'hippie-expand

      ;; Pasting
      :i "M-v" #'evil-paste-before

      :map +popup-mode-map
      :n "C-r" #'+popup/raise)

(after! which-key
  (define-key which-key-mode-map (kbd "<f1> C-h") 'which-key-C-h-dispatch))

;; in evil integriert via evil-escape-key-sequence
;; (general-def :states 'insert
;;   "j" (general-key-dispatch 'self-insert-command
;;         :timeout 0.25
;;         "k" 'evil-normal-state))

(map!
 :n "H-1" '+workspace/switch-to-0
 :n "H-2" '+workspace/switch-to-1
 :n "H-3" '+workspace/switch-to-2
 :n "H-4" '+workspace/switch-to-3
 :n "H-5" '+workspace/switch-to-4
 :n "H-6" '+workspace/switch-to-5
 :n "H-7" '+workspace/switch-to-6)

;; Leichtes Scrollen auf US Layout
(map!
 :n "H-j" 'evil-scroll-line-down
 :n "H-k" 'evil-scroll-line-up)


(map!
 :n "*" 'symbol-overlay-put)

(map!
 :n "<C-tab>" 'nswbuff-switch-to-next-buffer
 :n "<H-tab>" 'nswbuff-switch-to-previous-buffer)

(map!
 :n "J" 'avy-goto-char-2)

(map!
 :map dired-mode-map
 :n "%" nil
 :n "%u" #'dired-upcase
 :n "%l" #'dired-downcase
 :n "%d" #'dired-flag-files-regexp
 :n "%g" #'dired-mark-files-containing-regexp
 :n "%m" #'dired-mark-files-regexp
 :n "%r" #'dired-do-rename-regexp
 :n "%C" #'dired-do-copy-regexp
 :n "%H" #'dired-do-hardlink-regexp
 :n "%R" #'dired-do-rename-regexp
 :n "%S" #'dired-do-symlink-regexp
 :n "%&" #'dired-flag-garbage-files
 :n "%n" #'dired-narrow-regexp
 ;; dired subtree
 :n "<tab>" #'dired-subtree-cycle)

(map!
 :after evil-matchit
 :map dired-mode-map
 :n "#" dired-filter-map)

(map! :ng "C-x C-n" '+treemacs/toggle)

(map! :map pdf-view-mode-map
      :n "i" 'org-noter-insert-note
      :n "I" 'org-noter-insert-precise-note
      :n "M-n" 'org-noter-sync-next-note
      :n "M-p" 'org-noter-sync-prev-note
      :n "n" 'org-noter
      :n "N" 'org-noter-kill-session
      :n "J" 'pdf-view-next-page
      :n "K" 'pdf-view-previous-page)

(map! :map ctl-x-map
      "b" '+helm/workspace-mini
      "B" 'helm-buffers-list)

(map! :n "g K" 'dash-at-point)

(map! :n "C-w u" 'winner-undo
      :n "C-w U" 'winner-redo)

(map!
 :map js2-mode-map
 :n "C-c C-e" 'nodejs-repl-send-buffer)

(map!
 :n "g T" 'centaur-tabs-forward
 :n "g t" 'centaur-tabs-backward)
;; (map!
;;  :i "RET" '+default/newline)

;; Latex
(map!
 :map LaTeX-mode-map
 :prefix doom-localleader-key
 :n "p" 'latex-preview-pane-mode)


(map!
 :map paredit-mode-map
 :ni "C-k" #'paredit-kill)

;; Org

(map!
 :leader
 :desc "Orb actions" "n r a" #'orb-note-actions
 :desc "Org-ref cite" "n R i" #'org-ref-insert-cite-with-completion
 :desc "Org-ref crossref" "n R c" #'crossref-add-bibtex-entry
 :desc "Org-ref hydra" "n R h" #'org-ref-bibtex-hydra/body
 :desc "Org-ref doi" "n R d" #'doi-add-bibtex-entry
 :desc "Helm bibtex" "n R b" #'helm-bibtex
 )

(map!
 :map org-mode-map
 :prefix "M-SPC"
 (:desc "insert"
  :prefix "i"
   :n "H" 'org-insert-heading
   :n "h" 'org-insert-subheading
   :n "s" 'org-insert-src-block
   :n "l u" 'org-web-tools-insert-link-for-url)
 (:desc "heading"
  :prefix "h"
   :n "a" 'helm-org-agenda-files-headings
   :n "b" 'helm-org-in-buffer-headings
   :n "p" 'helm-org-parent-headings))

(map!
 :map tuareg-mode-map
 :n ", c" 'own/run-compiler)

(map!
 :i "C-M-o" 'own/oe
 :i "C-M-a" 'own/ae
 :i "C-M-u" 'own/ue
 :i "C-M-s" 'own/ss
 :i "C-M-e" 'hippie-expan)

;; (MAP!
;;  :map haskell-mode-map
;;  :n ", f" 'hindent-reformat-buffer)

(map!
 :map ranger-normal-mode-map
 "S" '+eshell/toggle)

(map!
 :map doom-leader-map
 "f F" 'counsel-file-jump)

(map!
 :n "L" 'evil-end-of-line
 :n "H" 'evil-beginning-of-line
 :n "C-k" 'join-line)
