(setq platform "MAC")
;; Minimize garbage collection during startup
(setq gc-cons-threshold most-positive-fixnum)

;; Lower threshold back to 8 MiB (default is 800kB)
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (expt 2 23))))

(setq read-process-output-max (* 1024 1024))

;; Don't die when handling large, minified files
(global-so-long-mode 1)

(gcmh-mode 1)

;; (use-package modus-themes
 ;; :init
 ;; ;; Add all your customizations prior to loading the themes
 ;;  (setq modus-themes-italic-constructs t
 ;;       modus-themes-bold-constructs nil
 ;;       modus-themes-region '(bg-only no-extend))

 ;; ;; Load the theme files before enabling a theme
 ;; (modus-themes-load-themes)
 ;; :config
 ;; ;; Load the theme of your choice:
 ;; ;; (modus-themes-load-operandi) ;;
 ;; (modus-themes-load-vivendi)
 ;; :bind ("<f5>" . modus-themes-toggle)
 ;; )
;; (modus-themes-load-operandi)
;; (modus-themes-load-vivendi)

;;(setq doom-theme 'doom-dracula)
;; (setq doom-theme 'doom-wilmersdorf)
;;(setq doom-theme 'modus-operandi)
(setq doom-theme 'modus-vivendi)

(when (not (string= platform "TERMUX"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "JetBrainsMono Nerd Font" :foundry "nil" :slant normal :weight normal :height 161 :width normal)))))
)
(map! :leader
      :desc "Load new theme" "h t" #'load-theme)

(setq modus-themes-italic-constructs t
      modus-themes-bold-constructs nil
      modus-themes-mixed-fonts nil
      modus-themes-subtle-line-numbers nil
      modus-themes-intense-mouseovers nil
      modus-themes-deuteranopia t
      modus-themes-tabs-accented t
      modus-themes-variable-pitch-ui nil
      modus-themes-inhibit-reload t ; only applies to `customize-set-variable' and related

      modus-themes-fringes nil ; {nil,'subtle,'intense}

      ;; Options for `modus-themes-lang-checkers' are either nil (the
      ;; default), or a list of properties that may include any of those
      ;; symbols: `straight-underline', `text-also', `background',
      ;; `intense' OR `faint'.
      modus-themes-lang-checkers nil

      ;; Options for `modus-themes-mode-line' are either nil, or a list
      ;; that can combine any of `3d' OR `moody', `borderless',
      ;; `accented', a natural number for extra padding (or a cons cell
      ;; of padding and NATNUM), and a floating point for the height of
      ;; the text relative to the base font size (or a cons cell of
      ;; height and FLOAT)
      modus-themes-mode-line '(accented borderless (padding . 4) (height . 0.9))

      ;; Same as above:
      ;; modus-themes-mode-line '(accented borderless 4 0.9)

      ;; Options for `modus-themes-markup' are either nil, or a list
      ;; that can combine any of `bold', `italic', `background',
      ;; `intense'.
      modus-themes-markup '(background italic)

      ;; Options for `modus-themes-syntax' are either nil (the default),
      ;; or a list of properties that may include any of those symbols:
      ;; `faint', `yellow-comments', `green-strings', `alt-syntax'
      modus-themes-syntax nil

      ;; Options for `modus-themes-hl-line' are either nil (the default),
      ;; or a list of properties that may include any of those symbols:
      ;; `accented', `underline', `intense'
      modus-themes-hl-line '(underline accented)

      ;; Options for `modus-themes-paren-match' are either nil (the
      ;; default), or a list of properties that may include any of those
      ;; symbols: `bold', `intense', `underline'
      modus-themes-paren-match '(bold intense)

      ;; Options for `modus-themes-links' are either nil (the default),
      ;; or a list of properties that may include any of those symbols:
      ;; `neutral-underline' OR `no-underline', `faint' OR `no-color',
      ;; `bold', `italic', `background'
      modus-themes-links '(neutral-underline background)

      ;; Options for `modus-themes-box-buttons' are either nil (the
      ;; default), or a list that can combine any of `flat', `accented',
      ;; `faint', `variable-pitch', `underline', the symbol of any font
      ;; weight as listed in `modus-themes-weights', and a floating
      ;; point number (e.g. 0.9) for the height of the button's text.
      modus-themes-box-buttons '(variable-pitch flat faint 0.9)

      ;; Options for `modus-themes-prompts' are either nil (the
      ;; default), or a list of properties that may include any of those
      ;; symbols: `background', `bold', `gray', `intense', `italic'
      modus-themes-prompts '(intense bold)

      ;; The `modus-themes-completions' is an alist that reads three
      ;; keys: `matches', `selection', `popup'.  Each accepts a nil
      ;; value (or empty list) or a list of properties that can include
      ;; any of the following (for WEIGHT read further below):
      ;;
      ;; `matches' - `background', `intense', `underline', `italic', WEIGHT
      ;; `selection' - `accented', `intense', `underline', `italic', `text-also' WEIGHT
      ;; `popup' - same as `selected'
      ;; `t' - applies to any key not explicitly referenced (check docs)
      ;;
      ;; WEIGHT is a symbol such as `semibold', `light', or anything
      ;; covered in `modus-themes-weights'.  Bold is used in the absence
      ;; of an explicit WEIGHT.
      modus-themes-completions '((matches . (extrabold))
                                 (selection . (semibold accented))
                                 (popup . (accented intense)))

      modus-themes-mail-citations nil ; {nil,'intense,'faint,'monochrome}

      ;; Options for `modus-themes-region' are either nil (the default),
      ;; or a list of properties that may include any of those symbols:
      ;; `no-extend', `bg-only', `accented'
      modus-themes-region '(bg-only no-extend)

      ;; Options for `modus-themes-diffs': nil, 'desaturated, 'bg-only
      modus-themes-diffs 'desaturated

      modus-themes-org-blocks 'gray-background ; {nil,'gray-background,'tinted-background}

      modus-themes-org-agenda ; this is an alist: read the manual or its doc string
      '((header-block . (variable-pitch 1.3))
        (header-date . (grayscale workaholic bold-today 1.1))
        (event . (accented varied))
        (scheduled . uniform)
        (habit . traffic-light))

      modus-themes-headings ; this is an alist: read the manual or its doc string
      '((1 . (overline background variable-pitch 1.3))
        (2 . (rainbow overline 1.1))
        (t . (semibold))))

(add-hook! '+doom-dashboard-mode-hook (hide-mode-line-mode 1) (hl-line-mode -1))
(setq-hook! '+doom-dashboard-mode-hook evil-normal-state-cursor (list nil))

;; Thanks, but no thanks
(setq inhibit-startup-message t)

(when (not (string= platform "TERMUX"))
  (scroll-bar-mode -1)        ; Disable visible scrollbar
  (tool-bar-mode -1)          ; Disable the toolbar
  (tooltip-mode -1)           ; Disable tooltips
  (set-fringe-mode 10)        ; Give some breathing room
  (menu-bar-mode -1))         ; Disable the menu bar

;; Set up the visible bell
(setq visible-bell t)

;; Vertical Scroll
(setq scroll-step 1)
(setq scroll-margin 1)
(setq scroll-conservatively 101)
(setq scroll-up-aggressively 0.01)
(setq scroll-down-aggressively 0.01)
(setq auto-window-vscroll nil)
(setq fast-but-imprecise-scrolling nil)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq mouse-wheel-progressive-speed nil)
;; Horizontal Scroll
(setq hscroll-step 1)
(setq hscroll-margin 1)

(evil-define-minor-mode-key '(normal motion) 'evil-snipe-local-mode
  "s" #'avy-goto-char
  "S" #'avy-goto-char-2
  "w" #'avy-goto-word-1
  "W" #'avy-goto-word-0
  )

(evil-define-key '(normal motion visual) map
   "s" #'avy-goto-char
   "S" #'avy-goto-char-2
   "w" #'avy-goto-word-1
   "W" #'avy-goto-word-0
  )

;; remap gs-> keybinding
(map! :after evil-easymotion
      :map evilem-map
      "c"       #'avy-goto-char
      "C"       #'avy-goto-char-2
      "w"       #'avy-goto-word-1
      "W"       #'avy-goto-word-0
      "ll"      #'avy-goto-line
      "lu"      #'avy-goto-line-above
      "ld"      #'avy-goto-line-below
      )

;;; :editor evil
;; Focus new window after splitting
(setq evil-split-window-below t
      evil-vsplit-window-right t)
(defun san/save-and-kill-this-buffer ()
    (interactive)
    (save-buffer)
    (kill-this-buffer))
(evil-ex-define-cmd "q" #'kill-this-buffer)
(evil-ex-define-cmd "wq" #'san/save-and-kill-this-buffer)

(setq ivy-posframe-display-functions-alist
      '((swiper                     . ivy-posframe-display-at-point)
        (complete-symbol            . ivy-posframe-display-at-point)
        (counsel-M-x                . ivy-display-function-fallback)
        (counsel-esh-history        . ivy-posframe-display-at-window-center)
        (counsel-describe-function  . ivy-display-function-fallback)
        (counsel-describe-variable  . ivy-display-function-fallback)
        (counsel-find-file          . ivy-display-function-fallback)
        (counsel-recentf            . ivy-display-function-fallback)
        (counsel-register           . ivy-posframe-display-at-frame-bottom-window-center)
        (dmenu                      . ivy-posframe-display-at-frame-top-center)
        (nil                        . ivy-posframe-display))
      ivy-posframe-height-alist
      '((swiper . 20)
        (dmenu . 20)
        (t . 10)))
(ivy-posframe-mode 1) ; 1 enables posframe-mode, 0 disables it.

(map! :leader
      (:prefix ("v" . "Ivy")
       :desc "Ivy push view" "v p" #'ivy-push-view
       :desc "Ivy switch view" "v s" #'ivy-switch-view))

(use-package all-the-icons
  :if (display-graphic-p)
  :config
  (setq all-the-icons-scale-factor 0.8))

(use-package all-the-icons-ivy-rich
  :after counsel-projectile
  :init (all-the-icons-ivy-rich-mode +1)
  :config
  (setq all-the-icons-ivy-rich-icon-size 0.8))

(use-package ivy-rich
  :after all-the-icons-ivy-rich
  :init (ivy-rich-mode +1))

(map! :leader
      :desc "Comment or uncomment lines" "TAB TAB" #'comment-line
      (:prefix ("t" . "toggle")
       :desc "Toggle line numbers" "l" #'doom/toggle-line-numbers
       :desc "Toggle line highlight in frame" "h" #'hl-line-mode
       :desc "Toggle line highlight globally" "H" #'global-hl-line-mode
       :desc "Toggle truncate lines" "t" #'toggle-truncate-lines))

(map! :leader
      (:prefix ("e". "Eval/Email/Elfeed")
       :desc "Evaluate elisp in buffer" "b" #'eval-buffer
       :desc "Evaluate defun" "d" #'eval-defun
       :desc "Evaluate elisp expression" "e" #'eval-expression
       :desc "Evaluate last sexpression" "l" #'eval-last-sexp
       :desc "Evaluate elisp in region" "r" #'eval-region))

(map! :leader
      (:prefix ("r" . "registers")
       :desc "Copy to register" "c" #'copy-to-register
       :desc "Frameset to register" "f" #'frameset-to-register
       :desc "Insert contents of register" "i" #'insert-register
       :desc "Jump to register" "j" #'jump-to-register
       :desc "List registers" "l" #'list-registers
       :desc "Number to register" "n" #'number-to-register
       :desc "Interactively choose a register" "r" #'counsel-register
       :desc "View a register" "v" #'view-register
       :desc "Window configuration to register" "w" #'window-configuration-to-register
       :desc "Increment register" "+" #'increment-register
       :desc "Point to register" "SPC" #'point-to-register))

(when (not (string= platform "TERMUX"))
(after! lsp-mode
(use-package lsp-mode
  :defer t
  :commands lsp
  :custom
  (lsp-keymap-prefix "C-x l")
  (lsp-auto-guess-root nil)
  (lsp-prefer-flymake nil) ;; Use flycheck instead of flymake
  (lsp-enable-file-watchers nil)
  (lsp-enable-folding nil)
  (read-process-output-max (* 1024 1024))
  (lsp-keep-workspace-alive nil)
  (lsp-eldoc-hook nil)
  :bind (:map lsp-mode-map ("C-c C-f" . lsp-format-buffer))
  :hook ((java-mode python-mode go-mode rust-mode
          js-mode js2-mode typescript-mode web-mode
          c-mode c++-mode objc-mode) . lsp-deferred)
  :config
  (defun lsp-update-server ()
    "Update LSP server."
    (interactive)
    ;; Equals to `C-u M-x lsp-install-server'
    (lsp-install-server t)))

(setq lsp-ui-sideline-enable nil)
(require 'gradle-mode)
(add-hook 'java-mode-hook '(lambda() (gradle-mode 1)))

;;LSP UI

(use-package lsp-ui
  :after lsp-mode
  :diminish
  :commands lsp-ui-mode
  :custom-face
  (lsp-ui-doc-background ((t (:background nil))))
  (lsp-ui-doc-header ((t (:inherit (font-lock-string-face italic)))))
  :bind
  (:map lsp-ui-mode-map
        ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
        ([remap xref-find-references] . lsp-ui-peek-find-references)
        ("C-c u" . lsp-ui-imenu)
        ("M-i" . lsp-ui-doc-focus-frame))
  (:map lsp-mode-map
        ("M-n" . forward-paragraph)
        ("M-p" . backward-paragraph))
  :custom
  (lsp-ui-doc-header t)
  (lsp-ui-doc-include-signature t)
  (lsp-ui-doc-border (face-foreground 'default))
  (lsp-ui-sideline-enable nil)
  (lsp-ui-sideline-ignore-duplicate t)
  (lsp-ui-sideline-show-code-actions nil)
  :config
  ;; Use lsp-ui-doc-webkit only in GUI
  (when (display-graphic-p)
    (setq lsp-ui-doc-use-webkit t))
  ;; WORKAROUND Hide mode-line of the lsp-ui-imenu buffer
  ;; https://github.com/emacs-lsp/lsp-ui/issues/243
  (defadvice lsp-ui-imenu (after hide-lsp-ui-imenu-mode-line activate)
    (setq mode-line-format nil))
  ;; `C-g'to close doc
  (advice-add #'keyboard-quit :before #'lsp-ui-doc-hide))
)
(use-package lsp-mode
  :config
  (setq lsp-auto-guess-root t)
  (setq lsp-log-io nil)
  (setq lsp-restart 'auto-restart)
  (setq lsp-enable-symbol-highlighting nil)
  (setq lsp-enable-on-type-formatting nil)
  (setq lsp-signature-auto-activate nil)
  (setq lsp-signature-render-documentation nil)
  (setq lsp-eldoc-hook nil)
  (setq lsp-modeline-code-actions-enable nil)
  (setq lsp-modeline-diagnostics-enable nil)
  (setq lsp-headerline-breadcrumb-enable nil)
  (setq lsp-semantic-tokens-enable nil)
  (setq lsp-enable-folding nil)
  (setq lsp-enable-imenu nil)
  (setq lsp-enable-snippet nil)
  (setq read-process-output-max (* 1024 1024)) ;; 1MB
  (setq lsp-idle-delay 0.5))
)

(when (not (string= platform "TERMUX"))
(after! lsp-mode 
(lsp-register-client
 (make-lsp-client :new-connection (lsp-stdio-connection '("/usr/local/bin/terraform-ls" "serve"))
                  :major-modes '(terraform-mode)
                  :server-id 'terraform-ls))
(add-hook 'terraform-mode-hook #'lsp-deferred))
)

(when (not (string= platform "TERMUX"))
  (require 'dap-php)
)

(when (not (string= platform "TERMUX"))
  (after! company
    (setq company-minimum-prefix-length 2)
    (setq company-tooltip-align-annotations t)
    (setq company-require-match 'never)
    (setq company-idle-delay 0.3)
    (setq company-show-numbers t)
  )
)

(when (not (string= platform "TERMUX"))
)

(when (not (string= platform "TERMUX"))
  (use-package treemacs
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :custom
  (treemacs-collapse-dirs 3)
  (treemacs-deferred-git-apply-delay 0.5)
  (treemacs-display-in-side-window t)
  (treemacs-file-event-delay 5000)
  (treemacs-file-follow-delay 0.2)
  (treemacs-follow-after-init t)
  (treemacs-follow-recenter-distance 0.1)
  (treemacs-git-command-pipe "")
  (treemacs-goto-tag-strategy 'refetch-index)
  (treemacs-indentation 2)
  (treemacs-indentation-string " ")
  (treemacs-is-never-other-window nil)
  (treemacs-max-git-entries 5000)
  (treemacs-no-png-images nil)
  (treemacs-no-delete-other-windows t)
  (treemacs-project-follow-cleanup nil)
  (treemacs-persist-file (expand-file-name ".cache/treemacs-persist" user-emacs-directory))
  (treemacs-recenter-after-file-follow nil)
  (treemacs-recenter-after-tag-follow nil)
  (treemacs-show-cursor nil)
  (treemacs-show-hidden-files t)
  (treemacs-silent-filewatch nil)
  (treemacs-silent-refresh nil)
  (treemacs-sorting 'alphabetic-desc)
  (treemacs-space-between-root-nodes t)
  (treemacs-tag-follow-cleanup t)
  (treemacs-tag-follow-delay 1.5)
  (treemacs-width 25)
  :config
  ;; The default width and height of the icons is 22 pixels. If you are
  ;; using a Hi-DPI display, uncomment this to double the icon size.
  ;;(treemacs-resize-icons 44)
  (treemacs-follow-mode t)
  (treemacs-filewatch-mode t)
  (treemacs-fringe-indicator-mode t)
  :bind
  (("M-0"       . treemacs-select-window)
   ("C-x t 1"   . treemacs-delete-other-windows)
   ("C-x t B"   . treemacs-bookmark)
   ("C-x t C-t" . treemacs-find-file)
   ("C-x t M-t" . treemacs-find-tag))
  (:map treemacs-mode-map ("C-p" . treemacs-previous-line)))
  (map! :leader
      (:prefix ("f" . "file")
        :desc "Open Treemacs" "t" #'+treemacs/toggle))
)

(add-hook 'dired-mode-hook 'org-download-enable)

(defun my/org-mode/load-prettify-symbols () "Prettify org mode keywords"
  (interactive)
  (setq prettify-symbols-alist
    (mapcan (lambda (x) (list x (cons (upcase (car x)) (cdr x))))
          '(("#+begin_src" . ????)
            ("#+end_src" . ????)
            ("#+begin_example" . ????)
            ("#+end_example" . ????)
            ("#+DATE:" . ????)
            ("#+AUTHOR:" . ????)
            ("[ ]" .  ????)
            ("[X]" . ???? )
            ("[-]" . ???? )
            ("lambda" . ???)
            ("#+header:" . ????)
            ("#+name:" . ????)
            ("#+results:" . ????)
            ("#+call:" . ????)
            (":properties:" . ????)
            (":logbook:" . ????))))
  (prettify-symbols-mode 1))

(map! :leader
      :desc "Org babel tangle" "m B" #'org-babel-tangle)

(after! org
  (setq org-startup-folded t
  )
  (use-package org-superstar  ;; Improved version of org-bullets
  	:config
  (add-hook 'org-mode-hook (lambda () (org-superstar-mode 1))))
  (setq org-directory "~/org/"
        ;;org-agenda-files '("~/org/agenda.org")
        ;;org-default-notes-file (expand-file-name "notes.org" org-directory)
        org-ellipsis " ??? "
        org-log-done 'time
        org-journal-dir "~/org/journal/"
        org-journal-date-format "%B %d, %Y (%A) "
        org-journal-file-format "%Y-%m-%d.org"
       ;; org-display-inline-images t
       ;; org-redisplay-inline-images t
       ;; org-startup-with-inline-images "inlineimages"
        org-hide-emphasis-markers t
        ;; ex. of org-link-abbrev-alist in action
        ;; [[arch-wiki:Name_of_Page][Description]]
        org-link-abbrev-alist    ; This overwrites the default Doom org-link-abbrev-list
          '(("google" . "http://www.google.com/search?q=")
            ("arch-wiki" . "https://wiki.archlinux.org/index.php/")
            ("ddg" . "https://duckduckgo.com/?q=")
            ("wiki" . "https://en.wikipedia.org/wiki/"))
        org-todo-keywords        ; This overwrites the default Doom org-todo-keywords
          '((sequence
             "TODO(t)"           ; A task that is ready to be tackled
             "BOOK(k)"           ; A book to be read
             "ARTICLE(a)"        ; An article to be read
             "MOVIE(m)"          ; A movie to watch
             "TV(v)"             ; A tv series to watch
             "LEARN(l)"          ; A learning/skill I want to pick up
             "BLOG(b)"           ; Blog post to work on
             "YOUTUBE(y)"        ; Youtube video to work on
             "INPROGRESS(p)"     ; a task - in progress
             "READING(e)"        ; a task - in progress
             "WATCHING(g)"       ; a task - in progress
             "WAITING(w)"        ; Something is holding up this task
             "|"                 ; The pipe necessary to separate "active" states and "inactive" states
             "DONE(d)"           ; Task has been completed
             "READ(r)"           ; Book/Article has been read
             "WATCHED(h)"        ; Movie/TV Series has been watched
             "CANCELLED(c)" )))) ; Task has been cancelled

(after! org
        (setq org-agenda-files '("~/org/listibles/inbox.org"
                                 "~/org/listibles/gtd.org"
                                 "~/org/listibles/projects.org"
                                 "~/org/listibles/tickler.org"
                                 "~/org/listibles/work-cal.org"
                                 "~/org/listibles/personal-cal.org"
                                 "~/org/listibles/anniversaries.org"
                                 ))

(use-package org-capture
  :ensure nil
  :preface
  ;;(defvar my/org-basic-task-template "* TODO %^{Task}
  ;;	:PROPERTIES:
  ;;	:Effort: %^{effort|1:00|0:05|0:15|0:30|2:00|4:00}
  ;;	:END:
  ;;	Captured %<%Y-%m-%d %H:%M>" "Template for basic task.")

  (defvar my/org-ledger-income-template "%(org-read-date) %^{Payee}
  Income:%^{Account}  ???-%^{Amount}
  Assets:Savings:Kotak" "Template for income with ledger.")

  (defvar my/org-ledger-card-template "%(org-read-date) %^{Payee}
  Expenses:%^{Account}  ???%^{Amount}
  Liabilities:CC:Manhattan" "Template for credit card transaction with ledger.")

  (defvar my/org-ledger-cash-template "%(org-read-date) * %^{Payee}
  Expenses:%^{Account}  ???%^{Amount}
  Assets:Savings:Kotak" "Template for cash transaction with ledger.")

  :custom
  (org-capture-templates
   `(
     ("t" "Task Items")

     ("tt" "Todo [inbox]" entry (file+headline "~/org/listibles/inbox.org" "Tasks")
       "* TODO %^{TASK} %i%?"
	:immediate-finish t)

     ("tT" "Tickler" entry (file+headline "~/org/listibles/gtd.org" "Tickler")
       "* INPROGRESS %^{TASK} %i%? \n %U"
	:immediate-finish t)

     ("tb" "Blog" entry (file+headline "~/org/listibles/blog-and-youtube.org" "Blog")
       "* BLOG %^{TASK} %i%? :blog:"
	:immediate-finish t)

     ("ty" "Youtube" entry (file+headline "~/org/listibles/blog-and-youtube.org" "Youtube")
       "* YOUTUBE %^{TASK} %i%? :youtube:"
	:immediate-finish t)

          ("l" "Ledger")

     ("li" "Income" plain (file ,(format "~/org/ledger/ledger-%s.dat" (format-time-string "%Y"))),
      my/org-ledger-income-template
      :empty-lines 1
      :immediate-finish t)

     ("lc" "Credit Card" plain (file ,(format "~/org/ledger/ledger-%s.dat" (format-time-string "%Y"))),
      my/org-ledger-card-template
      :empty-lines 1
      :immediate-finish t)

     ("ld" "Debit from Bank" plain (file ,(format "~/org/ledger/ledger-%s.dat" (format-time-string "%Y"))),
      my/org-ledger-cash-template
      :empty-lines 1
      :immediate-finish t)

      ("b", "Books")

      ("bb" "General Book" entry (file+headline "~/org/listibles/books.org" "Books")
       "* BOOK %^{Book} :book: :general:book:"
       :immediate-finish t)

      ("bt" "Tech Book" entry (file+headline "~/org/listibles/books.org" "Tech Books")
       "* BOOK %^{Book} :book: :tech:book:"
       :immediate-finish t)

      ("e", "Learning")

      ("eg" "General Learning" entry (file+headline "~/org/listibles/learning.org" "Learning")
       "* LEARN %^{Topic} :general:learning:"
       :immediate-finish t)

      ("et" "Tech Learning" entry (file+headline "~/org/listibles/learning.org" "Tech Learning")
       "* LEARN %^{Topic} :tech:learning:"
       :immediate-finish t)

      ("o" "Movie" entry (file+headline "~/org/listibles/movies-and-tv.org" "Movies")
       "* MOVIE %^{Movie} :towatch:movie:"
       :immediate-finish t)

      ("t" "TV" entry (file+headline "~/org/listibles/movies-and-tv.org" "Series")
       "* TV %^{TV Series} :towatch:tv:"
       :immediate-finish t)

      ("w" "Wish List" checkitem (file+headline "~/org/listibles/wishlist.org" "WishList")
       "- [ ] %^{Item} :wishlist:"
       :immediate-finish t)

     ("m" "Mail")

     ("mt" "Mail Todo" entry (file+headline "~/org/listibles/inbox.org" "Mail Tasks")
       "* TODO Action - regarding /%:subject/ %a\n\n %i"
       :empty-lines 1
       :immediate-finish t)

     ("mf" "Mail Follow Up" entry (file+headline "~/org/listibles/inbox.org" "Mail Tasks")
       "* TODO Follow up with /%:fromaddress/ regarding /%:subject/ %a\n\n %i"
       :empty-lines 1
       :immediate-finish t)

   ;;  ("t" "Task" entry (file+headline "~/org/agenda/organizer.org" "Tasks"),
   ;;   my/org-basic-task-template
   ;;   :empty-lines 1)
	)))

	(setq org-refile-targets '(
			   ("~/org/listibles/gtd.org" :maxlevel . 3)
			   ("~/org/listibles/books.org" :maxlevel . 1)
			   ("~/org/listibles/learning.org" :maxlevel . 1)
			   ("~/org/listibles/blog-and-youtube.org" :maxlevel . 1)
			   ("~/org/listibles/movies-and-tv.org" :maxlevel . 1)
        ("~/org/listibles/someday.org" :maxlevel . 2)
        ("~/org/listibles/tickler.org" :maxlevel . 2)
			   ))

(setq org-agenda-custom-commands
    '(
        ("a" "My Agenda View"
         (
          (agenda 'day)
          (tags "@office+TODO=\"INPROGRESS\""
                     ((org-agenda-overriding-header "Office Tasks")
                      (org-agenda-files '("~/org/listibles/gtd.org"
                                          "~/org/listibles/inbox.org")))
           )
          (tags "personal+TODO=\"INPROGRESS\""
                     ((org-agenda-overriding-header "Personal Tasks")
                      (org-agenda-files '("~/org/listibles/gtd.org"
                                          "~/org/listibles/inbox.org")))
           )
          (tags "blog+TODO=\"INPROGRESS\""
                     ((org-agenda-overriding-header "Blog & Youtube")
                      (org-agenda-files '("~/org/listibles/blog-and-youtube.org")))
           )
          (tags "learning+TODO=\"INPROGRESS\""
                     ((org-agenda-overriding-header "Learning")
                      (org-agenda-files '("~/org/listibles/learning.org")))
           )
          (tags "book+TODO=\"READING\""
                     ((org-agenda-overriding-header "Books")
                      (org-agenda-files '("~/org/listibles/books.org")))
           )
          )
         )
        ("o" "At the office" tags-todo "@office"
         ((org-agenda-overriding-header "Office"))
         )
        ("p" "Personal" tags-todo "personal"
         ((org-agenda-overriding-header "Personal"))
         )
        ("b" "Books" tags-todo "book"
         ((org-agenda-overriding-header "Books")
          (org-agenda-files '("~/org/listibles/books.org")))
         )
        ("l" "Learning" tags-todo "learning"
         ((org-agenda-overriding-header "Learning")
          (org-agenda-files '("~/org/listibles/learning.org")))
         )
        ("y" "Blog & Youtube" tags-todo "blog|youtube"
         ((org-agenda-overriding-header "Blog & Youtube")
          (org-agenda-files '("~/org/listibles/blog-and-youtube.org")))
         )
        ("i" "Movies" tags-todo "movie"
         ((org-agenda-overriding-header "Movies")
          (org-agenda-files '("~/org/listibles/movies-and-tv.org")))
         )
        ("v" "On TV" tags-todo "tv"
         ((org-agenda-overriding-header "On TV")
          (org-agenda-files '("~/org/listibles/movies-and-tv.org")))
         )
        ("O" "All things office" tags "@office"
         ((org-agenda-overriding-header "Office"))
         )
        ("P" "All things Personal" tags "personal"
         ((org-agenda-overriding-header "Personal"))
         )
        ("B" "All Books" tags "book"
         ((org-agenda-overriding-header "Books")
          (org-agenda-files '("~/org/listibles/books.org")))
         )
        ("L" "All things Learning" tags "learning"
         ((org-agenda-overriding-header "Learning")
          (org-agenda-files '("~/org/listibles/learning.org")))
         )
        ("Y" "All Blog & Youtube" tags "blog|youtube"
         ((org-agenda-overriding-header "Blog & Youtube")
          (org-agenda-files '("~/org/listibles/blog-and-youtube.org")))
         )
        ("I" "All Movies" tags "movie"
         ((org-agenda-overriding-header "Movies")
          (org-agenda-files '("~/org/listibles/movies-and-tv.org")))
         )
        ("V" "All things On TV" tags "tv"
         ((org-agenda-overriding-header "On TV")
          (org-agenda-files '("~/org/listibles/movies-and-tv.org")))
         )
	)
)

(setq org-agenda-compact-blocks nil)
(setq org-agenda-restore-windows-after-quit t)
(setq org-agenda-skip-deadline-if-done t)
(setq org-agenda-skip-scheduled-if-done t)
(setq org-deadline-warning-days 90)
(setq org-agenda-start-on-weekday nil)
(setq org-agenda-sorting-strategy
      (quote
       ((agenda priority-down alpha-up)
        (todo priority-down alpha-up)
        (tags priority-down alpha-up))))
(setq org-agenda-prefix-format
      (quote
       ((agenda . "%s %?-12t %e ")
        (timeline . "  %s")
        (todo . " %i %e ")
        (tags . " %i %e ")
        (search . " %i %e "))))
(setq org-columns-default-format
      "%75ITEM %TODO %PRIORITY %SCHEDULED %DEADLINE %CLOSED %ALLTAGS")

(setq org-agenda-span 'week) ; default for all agenda commands

(defun my:org-agenda-day ()
   (interactive)
   (org-agenda nil "a"))

(setq org-agenda-block-separator 45)

(map! :leader
      (:prefix ("oa")
       :desc "Directly Open Agenda" "a" #'my:org-agenda-day))
)

(after! org-roam
    (setq org-roam-directory "~/org/roam")
    (setq org-roam-dailies-directory "journal/")
)

(map! :leader
      :desc "Dailies today" "n r D" #'org-roam-dailies-capture-today)

;;(setq org-roam-dailies-capture-templates
;;      '(("d" "default" entry "* %<%I:%M %p>: %?"
;;         :if-new (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n"))))

(defun my-deft/strip-quotes (str)
  (cond ((string-match "\"\\(.+\\)\"" str) (match-string 1 str))
        ((string-match "'\\(.+\\)'" str) (match-string 1 str))
        (t str)))

(defun my-deft/parse-title-from-front-matter-data (str)
  (if (string-match "^title: \\(.+\\)" str)
      (let* ((title-text (my-deft/strip-quotes (match-string 1 str)))
             (is-draft (string-match "^draft: true" str)))
        (concat (if is-draft "[DRAFT] " "") title-text))))

(defun my-deft/deft-file-relative-directory (filename)
  (file-name-directory (file-relative-name filename deft-directory)))

(defun my-deft/title-prefix-from-file-name (filename)
  (let ((reldir (my-deft/deft-file-relative-directory filename)))
    (if reldir
        (concat (directory-file-name reldir) " > "))))

(defun my-deft/parse-title-with-directory-prepended (orig &rest args)
  (let ((str (nth 1 args))
        (filename (car args)))
    (concat
      (my-deft/title-prefix-from-file-name filename)
      (let ((nondir (file-name-nondirectory filename)))
        (if (or (string-prefix-p "README" nondir)
                (string-suffix-p ".txt" filename))
            nondir
          (if (string-prefix-p "---\n" str)
              (my-deft/parse-title-from-front-matter-data
               (car (split-string (substring str 4) "\n---\n")))
            (apply orig args)))))))

(after! deft 
(setq deft-directory "~/org"
      deft-extensions '("org" "txt")
      deft-recursive t
      deft-strip-summary-regexp ":PROPERTIES:\n\\(.+\n\\)+:END:\n"
      deft-use-filename-as-title nil
      deft-use-filter-string-for-filename t
      deft-file-naming-rules '((nospace . "-"))
)
(advice-add 'deft-parse-title :around #'my-deft/parse-title-with-directory-prepended)
)

(defun kill-this-buffer-volatile ()
    "Kill current buffer, even if it has been modified."
    (interactive)
    (set-buffer-modified-p nil)
    (kill-this-buffer))
(map! :map deft-mode-map
        :n "gr"  #'deft-refresh
        :n "C-s" #'deft-filter
        :i "C-n" #'deft-new-file
        :i "C-m" #'deft-new-file-named
        :i "C-d" #'deft-delete-file
        :i "C-r" #'deft-rename-file
        :n "r"   #'deft-rename-file
        :n "a"   #'deft-new-file
        :n "A"   #'deft-new-file-named
        :n "d"   #'deft-delete-file
        :n "D"   #'deft-archive-file
        :n "q"   #'kill-this-buffer-volatile)

(use-package ledger-mode
  :mode ("\\.dat\\'"
         "\\.ledger\\'")
  :bind (:map ledger-mode-map
              ("C-x C-s" . my/ledger-save))
  :hook (ledger-mode . ledger-flymake-enable)
  :preface
  (defun my/ledger-save ()
    "Automatically clean the ledger buffer at each save."
    (interactive)
    (ledger-mode-clean-buffer)
    (save-buffer))
  :custom
  (ledger-clear-whole-transactions t)
  (ledger-reconcile-default-commodity "INR")
  (add-to-list 'evil-emacs-state-modes 'ledger-report-mode)
  (ledger-reports
   '(("account statement" "%(binary) reg --real [[ledger-mode-flags]] -f %(ledger-file) ^%(account)")
     ("balance sheet" "%(binary) --real [[ledger-mode-flags]] -f %(ledger-file) bal ^assets ^liabilities ^equity")
     ("budget" "%(binary) --empty -S -T [[ledger-mode-flags]] -f %(ledger-file) bal ^assets:bank ^assets:receivables ^assets:cash ^assets:budget")
     ("budget goals" "%(binary) --empty -S -T [[ledger-mode-flags]] -f %(ledger-file) bal ^assets:bank ^assets:receivables ^assets:cash ^assets:'budget goals'")
     ("budget obligations" "%(binary) --empty -S -T [[ledger-mode-flags]] -f %(ledger-file) bal ^assets:bank ^assets:receivables ^assets:cash ^assets:'budget obligations'")
     ("budget debts" "%(binary) --empty -S -T [[ledger-mode-flags]] -f %(ledger-file) bal ^assets:bank ^assets:receivables ^assets:cash ^assets:'budget debts'")
     ("cleared" "%(binary) cleared [[ledger-mode-flags]] -f %(ledger-file)")
     ("equity" "%(binary) --real [[ledger-mode-flags]] -f %(ledger-file) equity")
     ("income statement" "%(binary) --invert --real -S -T [[ledger-mode-flags]] -f %(ledger-file) bal ^income ^expenses -p \"this month\""))
   (ledger-report-use-header-line nil)))

(use-package flycheck-ledger :after ledger-mode)

(use-package! elfeed-goodies)
(elfeed-goodies/setup)
(setq elfeed-goodies/entry-pane-size 0.5)
(add-hook 'elfeed-show-mode-hook 'visual-line-mode)
(evil-define-key 'normal elfeed-show-mode-map
  (kbd "J") 'elfeed-goodies/split-show-next
  (kbd "K") 'elfeed-goodies/split-show-prev)
(evil-define-key 'normal elfeed-search-mode-map
  (kbd "J") 'elfeed-goodies/split-show-next
  (kbd "K") 'elfeed-goodies/split-show-prev)
(setq elfeed-db-directory (expand-file-name "elfeed" user-emacs-directory))
(setq rmh-elfeed-org-files (list "~/org/elfeed.org"))
;; (setq elfeed-feeds (quote (
;;                      ("https://www.reddit.com/r/emacs.rss" reddit emacs)
;;                      ("https://sachachua.com/blog/category/emacs/feed" sachachua emacs)
;;                      ("http://feeds.bbci.co.uk/news/world/rss.xml" news world bbc)
;;                      ("https://www.aljazeera.com/xml/rss/all.xml" news world aljazeera)
;;                      ("https://www.dnaindia.com/feeds/india.xml" news india dna)
;;                      ("https://indianexpress.com/feed/" news india indianexpress)
;;                      ("https://timesofindia.indiatimes.com/rssfeedstopstories.cms" news india timesofindia)
;;                      ("http://feeds.bbci.co.uk/news/technology/rss.xml" news tech bbc)
;;                      ("https://www.wired.com/feed/rss" news tech wired)
;;                      ("https://www.technologyreview.com/feed/" news tech mit)
;;                      ("https://www.sciencedaily.com/rss/top/science.xml" nature sciencedaily)
;;                      ("https://www.sciencedaily.com/rss/top.xml" nature topscience)
;;                      ("https://www.jetpens.com/blog/feed" stationery jetpens)
;;                     )))

(map! :leader
      (:prefix ("e")
       :desc "Open Elfeed" "f" #'elfeed))

(map! :map elfeed-search-mode-map
      :after elfeed-search
      [remap kill-this-buffer] "q"
      [remap kill-buffer] "q"
      :n doom-leader-key nil
      ;; :n "q" #'+rss/quit
      :n "e" #'elfeed-update
      :n "r" #'elfeed-search-untag-all-unread
      :n "u" #'elfeed-search-tag-all-unread
      :n "s" #'elfeed-search-live-filter
      :n "RET" #'elfeed-search-show-entry
      :n "p" #'elfeed-show-pdf
      :n "+" #'elfeed-search-tag-all
      :n "-" #'elfeed-search-untag-all
      :n "S" #'elfeed-search-set-filter
      :n "b" #'elfeed-search-browse-url
      :n "y" #'elfeed-search-yank)

(map! :map elfeed-show-mode-map
      :after elfeed-show
      [remap kill-this-buffer] "q"
      [remap kill-buffer] "q"
      :n doom-leader-key nil
      :nm "q" #'+rss/delete-pane
      :nm "o" #'ace-link-elfeed
      :nm "RET" #'org-ref-elfeed-add
      :nm "n" #'elfeed-show-next
      :nm "N" #'elfeed-show-prev
      :nm "p" #'elfeed-show-pdf
      :nm "+" #'elfeed-show-tag
      :nm "-" #'elfeed-show-untag
      :nm "s" #'elfeed-show-new-live-search
      :nm "y" #'elfeed-show-yank)

(after! elfeed-search
  (set-evil-initial-state! 'elfeed-search-mode 'normal))
(after! elfeed-show-mode
  (set-evil-initial-state! 'elfeed-show-mode   'normal))

(after! evil-snipe
  (push 'elfeed-show-mode   evil-snipe-disabled-modes)
  (push 'elfeed-search-mode evil-snipe-disabled-modes))

(after! elfeed

  ;; (elfeed-org)
  (use-package! elfeed-link)

  (setq elfeed-search-filter "@4-week-ago +unread"
        elfeed-search-print-entry-function '+rss/elfeed-search-print-entry
        elfeed-search-title-min-width 80
        elfeed-show-entry-switch #'pop-to-buffer
        elfeed-show-entry-delete #'+rss/delete-pane
        elfeed-show-refresh-function #'+rss/elfeed-show-refresh--better-style
        shr-max-image-proportion 0.6)

  (add-hook! 'elfeed-show-mode-hook (hide-mode-line-mode 1))
  (add-hook! 'elfeed-search-update-hook #'hide-mode-line-mode)

  (defface elfeed-show-title-face '((t (:weight ultrabold :slant italic :height 1.5)))
    "title face in elfeed show buffer"
    :group 'elfeed)
  (defface elfeed-show-author-face `((t (:weight light)))
    "title face in elfeed show buffer"
    :group 'elfeed)
  (set-face-attribute 'elfeed-search-title-face nil
                      :foreground 'nil
                      :weight 'light)

  (defadvice! +rss-elfeed-wrap-h-nicer ()
    "Enhances an elfeed entry's readability by wrapping it to a width of `fill-column' and centering it with `visual-fill-column-mode'."
    :override #'+rss-elfeed-wrap-h
    (setq-local truncate-lines nil
                shr-width 120
                visual-fill-column-center-text t
                default-text-properties '(line-height 1.1))
    (let ((inhibit-read-only t)
          (inhibit-modification-hooks t))
      (visual-fill-column-mode)
      ;; (setq-local shr-current-font '(:family "Merriweather" :height 1.2))
      (set-buffer-modified-p nil)))

  (defun +rss/elfeed-search-print-entry (entry)
    "Print ENTRY to the buffer."
    (let* ((elfeed-goodies/tag-column-width 40)
           (elfeed-goodies/feed-source-column-width 30)
           (title (or (elfeed-meta entry :title) (elfeed-entry-title entry) ""))
           (title-faces (elfeed-search--faces (elfeed-entry-tags entry)))
           (feed (elfeed-entry-feed entry))
           (feed-title
            (when feed
              (or (elfeed-meta feed :title) (elfeed-feed-title feed))))
           (tags (mapcar #'symbol-name (elfeed-entry-tags entry)))
           (tags-str (concat (mapconcat 'identity tags ",")))
           (title-width (- (window-width) elfeed-goodies/feed-source-column-width
                           elfeed-goodies/tag-column-width 4))

           (tag-column (elfeed-format-column
                        tags-str (elfeed-clamp (length tags-str)
                                               elfeed-goodies/tag-column-width
                                               elfeed-goodies/tag-column-width)
                        :left))
           (feed-column (elfeed-format-column
                         feed-title (elfeed-clamp elfeed-goodies/feed-source-column-width
                                                  elfeed-goodies/feed-source-column-width
                                                  elfeed-goodies/feed-source-column-width)
                         :left)))

      (insert (propertize feed-column 'face 'elfeed-search-feed-face) " ")
      (insert (propertize tag-column 'face 'elfeed-search-tag-face) " ")
      (insert (propertize title 'face title-faces 'kbd-help title))
      (setq-local line-spacing 0.2)))

  (defun +rss/elfeed-show-refresh--better-style ()
    "Update the buffer to match the selected entry, using a mail-style."
    (interactive)
    (let* ((inhibit-read-only t)
           (title (elfeed-entry-title elfeed-show-entry))
           (date (seconds-to-time (elfeed-entry-date elfeed-show-entry)))
           (author (elfeed-meta elfeed-show-entry :author))
           (link (elfeed-entry-link elfeed-show-entry))
           (tags (elfeed-entry-tags elfeed-show-entry))
           (tagsstr (mapconcat #'symbol-name tags ", "))
           (nicedate (format-time-string "%a, %e %b %Y %T %Z" date))
           (content (elfeed-deref (elfeed-entry-content elfeed-show-entry)))
           (type (elfeed-entry-content-type elfeed-show-entry))
           (feed (elfeed-entry-feed elfeed-show-entry))
           (feed-title (elfeed-feed-title feed))
           (base (and feed (elfeed-compute-base (elfeed-feed-url feed)))))
      (erase-buffer)
      (insert "\n")
      (insert (format "%s\n\n" (propertize title 'face 'elfeed-show-title-face)))
      (insert (format "%s\t" (propertize feed-title 'face 'elfeed-search-feed-face)))
      (when (and author elfeed-show-entry-author)
        (insert (format "%s\n" (propertize author 'face 'elfeed-show-author-face))))
      (insert (format "%s\n\n" (propertize nicedate 'face 'elfeed-log-date-face)))
      (when tags
        (insert (format "%s\n"
                        (propertize tagsstr 'face 'elfeed-search-tag-face))))
      ;; (insert (propertize "Link: " 'face 'message-header-name))
      ;; (elfeed-insert-link link link)
      ;; (insert "\n")
      (cl-loop for enclosure in (elfeed-entry-enclosures elfeed-show-entry)
               do (insert (propertize "Enclosure: " 'face 'message-header-name))
               do (elfeed-insert-link (car enclosure))
               do (insert "\n"))
      (insert "\n")
      (if content
          (if (eq type 'html)
              (elfeed-insert-html content base)
            (insert content))
        (insert (propertize "(empty)\n" 'face 'italic)))
      (goto-char (point-min))))
  )

(when (not (string= platform "TERMUX"))
;;Control Spotify from within Emacs!
(setq counsel-spotify-client-id "7176a0f349d14df18735d93b09d46e60")
(setq counsel-spotify-client-secret "f7cd08f3ad784e76a268a3261f73e585")
(map! :leader
      (:prefix ("m" . "Music on Spotify")
       :desc "Search track" "s" #'counsel-spotify-search-track
       :desc "Spotify play/pause track" "x" #'counsel-spotify-toggle-play-pause
       :desc "Spotify play previous track" "p" #'counsel-spotify-previous
       :desc "Spotify play next track" "n" #'counsel-spotify-next))
)

(defun org2blog-init-login()
  (interactive)
  (org2blog/wp-login))

(defun org2blog-init-ui()
  (interactive)
  ;;(org2blog/wp-login)
  (org2blog-user-interface))

(setq org2blog/wp-blog-alist
      '(("framesofnature"
         :url "https://framesofnature.com/xmlrpc.php"
         :username "santh0sh"
         :password "v3ue2wux")))
(map! :leader
      (:prefix ("j" . "Journaling & Blogging")
       :desc "Login to your Blog" "l" #'org2blog-init-login
       :desc "Start Blogging" "b" #'org2blog-init-ui))

(require 'org-gcal)
(setq org-gcal-client-id "935116837597-uq64hfuicj3s4u9ugptqsb035m02ni2v.apps.googleusercontent.com"
      org-gcal-client-secret "YldSJ452JQrHC9yE1mr8kBIW"
      org-gcal-file-alist '(("santhosh.kris@gmail.com" .  "~/org/listibles/cal/personal-cal.org")))
;;(add-hook 'org-agenda-mode-hook (lambda () (org-gcal-sync) ))
;;(add-hook 'org-capture-after-finalize-hook (lambda () (org-gcal-sync) ))

;; https://stackoverflow.com/questions/9547912/emacs-calendar-show-more-than-3-months
(defun dt/year-calendar (&optional year)
  (interactive)
  (require 'calendar)
  (let* (
      (current-year (number-to-string (nth 5 (decode-time (current-time)))))
      (month 0)
      (year (if year year (string-to-number (format-time-string "%Y" (current-time))))))
    (switch-to-buffer (get-buffer-create calendar-buffer))
    (when (not (eq major-mode 'calendar-mode))
      (calendar-mode))
    (setq displayed-month month)
    (setq displayed-year year)
    (setq buffer-read-only nil)
    (erase-buffer)
    ;; horizontal rows
    (dotimes (j 4)
      ;; vertical columns
      (dotimes (i 3)
        (calendar-generate-month
          (setq month (+ month 1))
          year
          ;; indentation / spacing between months
          (+ 5 (* 25 i))))
      (goto-char (point-max))
      (insert (make-string (- 10 (count-lines (point-min) (point-max))) ?\n))
      (widen)
      (goto-char (point-max))
      (narrow-to-region (point-max) (point-max)))
    (widen)
    (goto-char (point-min))
    (setq buffer-read-only t)))

(defun dt/scroll-year-calendar-forward (&optional arg event)
  "Scroll the yearly calendar by year in a forward direction."
  (interactive (list (prefix-numeric-value current-prefix-arg)
                     last-nonmenu-event))
  (unless arg (setq arg 0))
  (save-selected-window
    (if (setq event (event-start event)) (select-window (posn-window event)))
    (unless (zerop arg)
      (let* (
              (year (+ displayed-year arg)))
        (dt/year-calendar year)))
    (goto-char (point-min))
    (run-hooks 'calendar-move-hook)))

(defun dt/scroll-year-calendar-backward (&optional arg event)
  "Scroll the yearly calendar by year in a backward direction."
  (interactive (list (prefix-numeric-value current-prefix-arg)
                     last-nonmenu-event))
  (dt/scroll-year-calendar-forward (- (or arg 1)) event))

(map! :leader
      :desc "Scroll year calendar backward" "<left>" #'dt/scroll-year-calendar-backward
      :desc "Scroll year calendar forward" "<right>" #'dt/scroll-year-calendar-forward)

(defalias 'year-calendar 'dt/year-calendar)

(use-package! calfw)
(use-package! calfw-org)

(when (not (string= platform "TERMUX"))
(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-application-framework/")
(require 'eaf)
(require 'eaf-browser)
(require 'eaf-pdf-viewer)

(use-package eaf
 :custom
 (eaf-browser-continue-where-left-off t)
 :config
 (setq eaf-browser-enable-adblocker t)
 (eaf-bind-key scroll_up "C-n" eaf-pdf-viewer-keybinding)
 (eaf-bind-key scroll_down "C-p" eaf-pdf-viewer-keybinding)
 (eaf-bind-key nil "M-q" eaf-browser-keybinding))

 (require 'eaf-evil)

(define-key key-translation-map (kbd "SPC")
   (lambda (prompt)
     (if (derived-mode-p 'eaf-mode)
         (pcase eaf--buffer-app-name
           ("browser" (if  (string= (eaf-call-sync "call_function" eaf--buffer-id "is_focus") "True")
                          (kbd "SPC")
                        (kbd eaf-evil-leader-key)))
           ("pdf-viewer" (kbd eaf-evil-leader-key))
           ("image-viewer" (kbd eaf-evil-leader-key))
           (_  (kbd "SPC")))
       (kbd "SPC"))))
)

(after! mu4e
;; we installed this with homebrew
(setq mu4e-mu-binary (executable-find "mu"))

;; this is the directory we created before:
(setq mu4e-maildir "~/MailDir")

;; this command is called to sync imap servers:
(setq mu4e-get-mail-command (concat (executable-find "mbsync") " -a"))
;; how often to call it in seconds:
(setq mu4e-update-interval 300)

;; save attachment to desktop by default
;; or another choice of yours:
(setq mu4e-attachment-dir "~/Downloads")

;; rename files when moving - needed for mbsync:
(setq mu4e-change-filenames-when-moving t)

;; list of your email adresses:
(setq mu4e-user-mail-address-list '("santhosh.fon@gmail.com"
                                    "santhosh.kris@gmail.com"))

;;(setq   mu4e-maildir-shortcuts
;;        '(("/gmail/INBOX" . ?f)
;;          ("/gmail-kris/INBOX" . ?g)
;;          ("/gmail-kris/[Gmail]/Sent Mail" . ?G)
;;          ("/gmail-kris/[Gmail]/All Mail" . ?A)))


(add-to-list 'mu4e-bookmarks
             (make-mu4e-bookmark
              :name "Inbox - Gmail-santhosh.fon"
              :query "maildir:/gmail/INBOX"
              :key ?f))

(add-to-list 'mu4e-bookmarks
             (make-mu4e-bookmark
              :name "Inbox - Gmail-santhosh.kris"
              :query "maildir:/gmail-kris/INBOX"
              :key ?g))
)

(after! mu4e
(require 'smtpmail)

;; gpg encryptiom & decryption:
;; this can be left alone
;;(require 'epa-file)
(epa-file-enable)
(setq epa-pinentry-mode 'loopback)
(auth-source-forget-all-cached)

(setq mu4e-contexts
      (list
       ;; santhosh.kris Gmail
       (make-mu4e-context
        :name "kris"
        :match-func
          (lambda (msg)
            (when msg
              (string-prefix-p "/gmail-kris" (mu4e-message-field msg :maildir))))
        :vars '((user-mail-address . "santhosh.kris@gmail.com")
                (user-full-name    . "Santhosh Krishnamoorthy")
                (smtpmail-smtp-server  . "smtp.gmail.com")
                (smtpmail-smtp-service . 465)
                (smtpmail-stream-type  . ssl)
                (mu4e-drafts-folder  . "/gmail-kris/[Gmail]/Drafts")
                (mu4e-sent-folder  . "/gmail-kris/[Gmail]/Sent Mail")
                (mu4e-refile-folder  . "/gmail-kris/[Gmail]/All Mail")
                (mu4e-trash-folder  . "/gmail-kris/[Gmail]/Trash")))

       ;; santhosh.fon Gmail
       (make-mu4e-context
        :name "fon"
        :match-func
          (lambda (msg)
            (when msg
              (string-prefix-p "/gmail" (mu4e-message-field msg :maildir))))
        :vars '((user-mail-address . "santhosh.fon@gmail.com")
                (user-full-name    . "Santhosh FON")
                (smtpmail-smtp-server  . "smtp.gmail.com")
                (smtpmail-smtp-service . 465)
                (smtpmail-stream-type  . ssl)
                (mu4e-drafts-folder  . "/gmail/[Gmail]/Drafts")
                (mu4e-sent-folder  . "/gmail/[Gmail]/Sent Mail")
                (mu4e-refile-folder  . "/gmail/[Gmail]/All Mail")
                (mu4e-trash-folder  . "/gmail/[Gmail]/Trash")))))

(setq mu4e-context-policy 'pick-first) ;; start with the first (default) context;
(setq mu4e-compose-context-policy 'ask) ;; ask for context if no context matches;

;; chose from account before sending
;; this is a custom function that works for me.
;; well I stole it somewhere long ago.
;; I suggest using it to make matters easy
;; of course adjust the email adresses and account descriptions
(defun timu/set-msmtp-account ()
  (if (message-mail-p)
      (save-excursion
        (let*
            ((from (save-restriction
                     (message-narrow-to-headers)
                     (message-fetch-field "from")))
             (account
              (cond
               ((string-match "santhosh.kris@gmail.com" from) "gmail-kris")
               ((string-match "santhosh.fon@gmail.com" from) "gmail-fon")
               ((string-match "dummy@example.com" from) "example"))))
          (setq message-sendmail-extra-arguments (list '"-a" account))))))

;;(add-hook 'message-send-mail-hook 'timu/set-msmtp-account)

;; mu4e cc & bcc
;; this is custom as well
(add-hook 'mu4e-compose-mode-hook
          (defun timu/add-cc-and-bcc ()
            "My Function to automatically add Cc & Bcc: headers.
    This is in the mu4e compose mode."
            (save-excursion (message-add-header "Cc:\n"))
            (save-excursion (message-add-header "Bcc:\n"))))

;; mu4e address completion
;;(add-hook 'mu4e-compose-mode-hook 'company-mode)


;; don't keep message compose buffers around after sending:
(setq message-kill-buffer-on-exit t)

;; send function:
;;(setq send-mail-function 'sendmail-send-it
;;      message-send-mail-function 'sendmail-send-it)

;; send program:
;;(setq sendmail-program (executable-find "msmtp"))

(setq sendmail-program (executable-find "msmtp")
      message-sendmail-f-is-evil t
      message-sendmail-extra-arguments '("--read-envelope-from")
      send-mail-function 'smtpmail-send-it
      message-send-mail-function 'message-send-mail-with-sendmail)

;; select the right sender email from the context.
(setq message-sendmail-envelope-from 'header)

)

(after! mu4e
;; store link to message if in header view, not to header query:
(setq org-mu4e-link-query-in-headers-mode nil)
;; don't have to confirm when quitting:
(setq mu4e-confirm-quit nil)
;; number of visible headers in horizontal split view:
(setq mu4e-headers-visible-lines 20)
;; don't show threading by default:
(setq mu4e-headers-show-threads nil)
;; hide annoying "mu4e Retrieving mail..." msg in mini buffer:
(setq mu4e-hide-index-messages t)
;; customize the reply-quote-string:
(setq message-citation-line-format "%N @ %Y-%m-%d %H:%M :\n")
;; M-x find-function RET message-citation-line-format for docs:
(setq message-citation-line-function 'message-insert-formatted-citation-line)
;; by default do not show related emails:
(setq mu4e-headers-include-related nil)
;; by default do not show threads:
(setq mu4e-headers-show-threads nil)


(defun skm/capture-mail-todo-action (msg)
  (interactive)
  (call-interactively 'org-store-link)
  (org-capture nil "mt"))

(defun skm/capture-mail-follow-up-action (msg)
  (interactive)
  (call-interactively 'org-store-link)
  (org-capture nil "mf"))

;; Add custom actions for our capture templates
(add-to-list 'mu4e-headers-actions
  '("follow up" . skm/capture-mail-follow-up-action) t)
(add-to-list 'mu4e-view-actions
  '("follow up" . skm/capture-mail-follow-up-action) t)
(add-to-list 'mu4e-headers-actions
  '("todo add" . skm/capture-mail-todo-action) t)
(add-to-list 'mu4e-view-actions
  '("todo add" . skm/capture-mail-todo-action) t)

(defun skm/store-link-to-mu4e-query ()
  (interactive)
  (let ((mu4e-org-link-query-in-headers-mode t))
    (call-interactively 'org-store-link)))
)

(map! :leader
      (:prefix ("e")
       :desc "Open Email" "m" #'mu4e
       :desc "Compose new Email" "c" #'mu4e-compose-new))

(require 'org-mime)
(setq org-mime-export-options '(:section-numbers nil
                                :with-author nil
                                :with-toc nil))
(add-hook 'message-send-hook 'org-mime-confirm-when-no-multipart)

(use-package emojify
  :hook (after-init . global-emojify-mode))

(map! :leader
      (:prefix ("k" . "open file")
       :desc "Open Ledger file" "l" #'(lambda () (interactive) (find-file "~/org/ledger/ledger-2021.dat"))
       :desc "Open doom config.org" "c" #'(lambda () (interactive) (find-file "~/dotfiles/doom/config.org"))
       :desc "Open doom init.el" "i" #'(lambda () (interactive) (find-file "~/dotfiles/doom/init.el"))
       :desc "Open doom packages.el" "p" #'(lambda () (interactive) (find-file "~/dotfiles/doom/packages.el"))))

;;going with the 'medium' to begin with
(setq sudoku-level 'medium)

(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
;;Some additional settings
(setq nov-text-width 80)
(defun my-nov-font-setup ()
  (face-remap-add-relative 'variable-pitch :family "Liberation Serif"
                                           :height 1.4))
(add-hook 'nov-mode-hook 'my-nov-font-setup)

(use-package! visual-fill-column)

(after! which-key
  (setq! which-key-idle-delay 0.1
         which-key-idle-secondary-delay 0.2))

(setq which-key-allow-multiple-replacements t)
(after! which-key
  (pushnew!
   which-key-replacement-alist
   '(("" . "\\`+?evil[-:]?\\(?:a-\\)?\\(.*\\)") . (nil . "???\\1"))
   '(("\\`g s" . "\\`evilem--?motion-\\(.*\\)") . (nil . "???\\1"))
   ))

(when (not (string= platform "TERMUX"))
  (setq-default
   delete-by-moving-to-trash t                      ; Delete files to trash
   window-combination-resize t                      ; take new window space from all other windows (not just current)
   x-stretch-cursor t)                              ; Stretch cursor to the glyph width

  (setq undo-limit 80000000                         ; Raise undo-limit to 80Mb
        evil-want-fine-undo t                       ; By default while in insert all changes are one big blob. Be more granular
        auto-save-default t                         ; Nobody likes to loose work, I certainly don't
        truncate-string-ellipsis "???"                ; Unicode ellispis are nicer than "...", and also save /precious/ space
        password-cache-expiry nil                   ; I can trust my computers ... can't I?
        scroll-preserve-screen-position 'always     ; Don't have `point' jump around
        scroll-margin 2                            ; It's nice to maintain a little margin
        )

  (display-time-mode 1)                             ; Enable time in the mode-line

  (unless (string-match-p "^Power N/A" (battery))   ; On laptops...
    (display-battery-mode 1))                       ; it's nice to know how much power you have

  (global-subword-mode 1)                           ; Iterate through CamelCase words
  (ace-link-setup-default)

  ;; Start maximised (cross-platf)
  ;; (add-hook 'window-setup-hook 'toggle-frame-maximized t)
  ;; Start fullscreen (cross-platf)
  (add-hook 'window-setup-hook 'toggle-frame-fullscreen t)
  (global-writeroom-mode 1)
)

;; "monospace" means use the system default. However, the default is usually two
;; points larger than I'd like, so I specify size 12 here.
;;(setq doom-font (font-spec :family "JetBrainsMono" :size 12 :weight 'light)
;;      doom-variable-pitch-font (font-spec :family "Noto Serif" :size 13)
;;      ivy-posframe-font (font-spec :family "JetBrainsMono" :size 15))

;; Prevents some cases of Emacs flickering
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))

(set-frame-parameter (selected-frame) 'alpha '(95 . 95))
(add-to-list 'default-frame-alist '(alpha . (95 . 95)))

;; When I bring up Doom's scratch buffer with SPC x, it's often to play with
;; elisp or note something down (that isn't worth an entry in my org files). I
;; can do both in `lisp-interaction-mode'.
(setq doom-scratch-initial-major-mode 'lisp-interaction-mode)

;; Line numbers are pretty slow all around. The performance boost of
;; disabling them outweighs the utility of always keeping them on.
(setq display-line-numbers-type nil)

;; The modeline is not useful to me in the popup window. It looks much nicer
;; to hide it.

(remove-hook 'emacs-everywhere-init-hooks #'hide-mode-line-mode)

(setq fancy-splash-image (concat doom-private-dir "splash.png"))

;; Hide the menu for as minimalistic a startup screen as possible.
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)

;;ace-window
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
(setq aw-dispatch-always t)

(defun enable_word_wrap()
  (setq-default word-wrap t)
  (setq fill-column 90)
  (setq visual-fill-column-width 90)
  (global-visual-fill-column-mode +1)
  (+global-word-wrap-mode +1)
  )

;;(enable_word_wrap)

(setq confirm-kill-processes nil)
(setq frame-resize-pixelwise t)

(map! :leader
      (:prefix ("t" . "Yoda - Global Zen Mode")
       :desc "Yoda - Global Zen Mode" "y" #'global-writeroom-mode
       )
      (:desc "Search this buffer" "s b" #'consult-line)
      (:desc "Recent files" "f r" #'counsel-recentf)
      (:desc "Switch to buffer" "b i" #'counsel-switch-buffer)
)
(global-set-key (kbd "C-M-s-o") 'ace-window)

;;(map! :leader
;;      :desc "Search this buffer" "s b" #'consult-line)
