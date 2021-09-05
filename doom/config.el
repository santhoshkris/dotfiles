(setq platform "MAC")

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

;;(setq doom-theme 'doom-gruvbox)
(setq doom-theme 'doom-dracula)
(map! :leader
      :desc "Load new theme" "h t" #'load-theme)

;;(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)
(add-hook! '+doom-dashboard-mode-hook (hide-mode-line-mode 1) (hl-line-mode -1))
(setq-hook! '+doom-dashboard-mode-hook evil-normal-state-cursor (list nil))

;; Thanks, but no thanks
(setq inhibit-startup-message t)

(when (not (string= platform "TERMUX"))
  (scroll-bar-mode -1)        ; Disable visible scrollbar
  (tool-bar-mode -1)          ; Disable the toolbar
  (tooltip-mode -1)           ; Disable tooltips
  (set-fringe-mode 10))       ; Give some breathing room

(menu-bar-mode -1)            ; Disable the menu bar

;; Set up the visible bell
(setq visible-bell t)

(use-package emojify
  :hook (after-init . global-emojify-mode))

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

(map! :leader
      (:prefix ("e". "evaluate/EWW")
       :desc "Evaluate elisp in buffer" "b" #'eval-buffer
       :desc "Evaluate defun" "d" #'eval-defun
       :desc "Evaluate elisp expression" "e" #'eval-expression
       :desc "Evaluate last sexpression" "l" #'eval-last-sexp
       :desc "Evaluate elisp in region" "r" #'eval-region))

(when (not (string= platform "TERMUX"))
(add-to-list 'load-path "~/.emacs.d/.local/straight/repos/eaf/")
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

(setq display-line-numbers-type t)
(map! :leader
      :desc "Comment or uncomment lines" "TAB TAB" #'comment-line
      (:prefix ("t" . "toggle")
       :desc "Toggle line numbers" "l" #'doom/toggle-line-numbers
       :desc "Toggle line highlight in frame" "h" #'hl-line-mode
       :desc "Toggle line highlight globally" "H" #'global-hl-line-mode
       :desc "Toggle truncate lines" "t" #'toggle-truncate-lines))

(add-hook 'dired-mode-hook 'org-download-enable)

(defun my/org-mode/load-prettify-symbols () "Prettify org mode keywords"
  (interactive)
  (setq prettify-symbols-alist
    (mapcan (lambda (x) (list x (cons (upcase (car x)) (cdr x))))
          '(("#+begin_src" . ?)
            ("#+end_src" . ?)
            ("#+begin_example" . ?)
            ("#+end_example" . ?)
            ("#+DATE:" . ?⏱)
            ("#+AUTHOR:" . ?✏)
            ("[ ]" .  ?☐)
            ("[X]" . ?☑ )
            ("[-]" . ?❍ )
            ("lambda" . ?λ)
            ("#+header:" . ?)
            ("#+name:" . ?﮸)
            ("#+results:" . ?)
            ("#+call:" . ?)
            (":properties:" . ?)
            (":logbook:" . ?))))
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
        org-ellipsis " ▼ "
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
            ;; "BLOG(b)"           ; Blog writing assignments
            ;; "PROJ(p)"           ; A project that contains other tasks
            ;; "VIDEO(v)"          ; Video assignments
             "WAITING(w)"           ; Something is holding up this task
             "|"                 ; The pipe necessary to separate "active" states and "inactive" states
             "DONE(d)"           ; Task has been completed
             "CANCELLED(c)" )))) ; Task has been cancelled

(after! org
        (setq org-agenda-files '("~/org/gtd/inbox.org"
                         "~/org/gtd/gtd.org"
                         "~/org/gtd/tickler.org"))

(use-package org-capture
  :ensure nil
  :preface
  ;;(defvar my/org-basic-task-template "* TODO %^{Task}
  ;;	:PROPERTIES:
  ;;	:Effort: %^{effort|1:00|0:05|0:15|0:30|2:00|4:00}
  ;;	:END:
  ;;	Captured %<%Y-%m-%d %H:%M>" "Template for basic task.")

  (defvar my/org-ledger-income-template "%(org-read-date) %^{Payee}
  Income:%^{Account}  ₹%^{Amount}
  Assets:Bank:Checking" "Template for income with ledger.")

  (defvar my/org-ledger-card-template "%(org-read-date) %^{Payee}
  Expenses:%^{Account}    ₹%^{Amount}
  Liabilities:CreditCards:Manhattan" "Template for credit card transaction with ledger.")

  (defvar my/org-ledger-cash-template "%(org-read-date) * %^{Payee}
  Expenses:%^{Account}  ₹%^{Amount}
  Assets:Bank:Checking" "Template for cash transaction with ledger.")

  :custom
  (org-capture-templates
   `(
     ("B" "Book" checkitem (file+headline "~/org/other/books.org" "Books")
      "- [ ] %^{Book}"
      :immediate-finish t)

     ("L" "Learning" checkitem (file+headline "~/org/other/learning.org" "Things")
      "- [ ] %^{Thing}"
      :immediate-finish t)

     ("M" "Movie" checkitem (file+headline "~/org/other/movies.org" "Movies")
      "- [ ] %^{Movie}"
      :immediate-finish t)

     ("P" "Purchase" checkitem (file+headline "~/org/other/purchases.org" "Purchases")
      "- [ ] %^{Item}"
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

      ("t" "Todo [inbox]" entry (file+headline "~/org/gtd/inbox.org" "Tasks")
       "* TODO %i%?")

      ("T" "Tickler" entry (file+headline "~/org/gtd/tickler.org" "Tickler")
       "* %i%? \n %U")

   ;;  ("t" "Task" entry (file+headline "~/org/agenda/organizer.org" "Tasks"),
   ;;   my/org-basic-task-template
   ;;   :empty-lines 1)
	)))

	(setq org-refile-targets '(("~/org/gtd/gtd.org" :maxlevel . 3)
                           ("~/org/gtd/someday.org" :level . 1)
                           ("~/org/gtd/tickler.org" :maxlevel . 2)))

        (setq org-agenda-custom-commands
                '(("o" "At the office" tags-todo "@office"
                ((org-agenda-overriding-header "Office"))))))

(after! org-roam
(setq org-roam-directory "~/org/roam")
;;(setq org-roam-dailies-directory "journal/")
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

(use-package! visual-fill-column)

(after! which-key
  (setq! which-key-idle-delay 0.1
         which-key-idle-secondary-delay 0.2))

(setq which-key-allow-multiple-replacements t)
(after! which-key
  (pushnew!
   which-key-replacement-alist
   '(("" . "\\`+?evil[-:]?\\(?:a-\\)?\\(.*\\)") . (nil . "◂\\1"))
   '(("\\`g s" . "\\`evilem--?motion-\\(.*\\)") . (nil . "◃\\1"))
   ))

(when (not (string= platform "TERMUX"))
  (setq-default
   delete-by-moving-to-trash t                      ; Delete files to trash
   window-combination-resize t                      ; take new window space from all other windows (not just current)
   x-stretch-cursor t)                              ; Stretch cursor to the glyph width

  (setq undo-limit 80000000                         ; Raise undo-limit to 80Mb
        evil-want-fine-undo t                       ; By default while in insert all changes are one big blob. Be more granular
        auto-save-default t                         ; Nobody likes to loose work, I certainly don't
        truncate-string-ellipsis "…"                ; Unicode ellispis are nicer than "...", and also save /precious/ space
        password-cache-expiry nil                   ; I can trust my computers ... can't I?
        scroll-preserve-screen-position 'always     ; Don't have `point' jump around
        scroll-margin 2                            ; It's nice to maintain a little margin
        )

  (display-time-mode 1)                             ; Enable time in the mode-line

  (unless (string-match-p "^Power N/A" (battery))   ; On laptops...
    (display-battery-mode 1))                       ; it's nice to know how much power you have

  (global-subword-mode 1)                           ; Iterate through CamelCase words
  (setq display-line-numbers-type t)
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

(map! :leader
      (:prefix ("t" . "Yoda - Global Zen Mode")
       :desc "Yoda - Global Zen Mode" "y" #'global-writeroom-mode
       ))

(setq confirm-kill-processes nil)
