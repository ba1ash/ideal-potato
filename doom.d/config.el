;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq! user-full-name "Pavel"
       user-mail-address "ba1ashpash@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
(setq! doom-font (font-spec :family "monospace" :size 20 :weight 'semi-light))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq! doom-theme 'doom-dracula)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq! display-line-numbers-type 'relative)
(setq! projectile-project-search-path '("~/prj"))


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq! org-directory "~/org/")
(setq! org-habit-show-habits t)
(setq! org-log-into-drawer t)
(setq! org-modules (quote (ol-bibtex org-habit)))
(after! org
  ;; (setq! org-default-notes-file "inbox.org")
  ;; (setq! org-capture-todo-file "inbox.org")
  (setq! org-capture-templates
         '(("i" "Inbox" entry (file+headline "~/org/gtd.org" "Inbox")
            "** %?\n  %i\n  %a")))
  (setq! org-todo-keywords
         '((sequence
            "TODO(t)"  ; A task that needs doing & is ready to do
            "STRT(s)"  ; A task that is in progress
            "WAIT(w)"  ; Something external is holding up this task
            "|"
            "DONE(d)"  ; Task successfully completed
            "KILL(k)") ; Task was cancelled, aborted or is no longer applicable
           (sequence
            "PROJ"
            "|"
            "PRDN")
           (sequence
            "[ ](T)"
            "[-](S)"
            "[?](W)"
            "|"
            "[X](D)"))
         org-todo-keyword-faces
         '(("[-]"  . +org-todo-active)
           ("STRT" . +org-todo-active)
           ("[?]"  . +org-todo-onhold)
           ("WAIT" . +org-todo-onhold)
           ("HOLD" . +org-todo-onhold)
           ("PROJ" . +org-todo-project))))

(setq geiser-active-implementations '(mit))

(after! rustic
  (setq rustic-lsp-server 'rust-analyzer))

(setq auto-mode-alist
      (append
       ;; File name (within directory) starts with a dot.
       '(("\\.haml\\'" . haml-mode)
         ("\\html\.haml\\'" . haml-mode))
       auto-mode-alist))

(remove-hook 'doom-first-buffer-hook #'smartparens-global-mode)
(after! smartparens
  (smartparens-global-mode -1))
