;; Insert line before
(defun bol-and-inl ()
  (interactive)
  (beginning-of-visual-line)
  (newline-and-indent)
  (previous-line))
(global-set-key (kbd "<S-s-return>") 'bol-and-inl)

;; Insert line after
(defun eof-and-inl ()
  (interactive)
  (end-of-line)
  (newline-and-indent))
(global-set-key (kbd "<s-return>") 'eof-and-inl)

;; Expand selection
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;;
;; Navigate bracketes
;;
(defvar otrenav-left-brackets nil "list of open bracket chars.")
(setq otrenav-left-brackets '("(" "{" "[" "<" "〔" "【" "〖" "〈" "《" "「" "『" "“" "‘" "‹" "«"))

(defvar otrenav-right-brackets nil "list of close bracket chars.")
(setq otrenav-right-brackets '(")" "]" "}" ">" "〕" "】" "〗" "〉" "》" "」" "』" "”" "’" "›" "»"))

(defun otrenav-backward-left-bracket ()
  "Move cursor to the previous occurrence of left bracket.
The list of brackets to jump to is defined by `otrenav-left-brackets'."
  (interactive)
  (search-backward-regexp (eval-when-compile (regexp-opt otrenav-left-brackets)) nil t))

(defun otrenav-forward-right-bracket ()
  "Move cursor to the next occurrence of right bracket.
The list of brackets to jump to is defined by `otrenav-right-brackets'."
  (interactive)
  (search-forward-regexp (eval-when-compile (regexp-opt otrenav-right-brackets)) nil t))

;;
;; Navigate quotes
;;
(defvar otrenav-ascii-quotes nil "List of quotation chars.")
(setq otrenav-ascii-quotes '("'" "\""))

(defun otrenav-forward-quote ()
  "Move cursor to the next occurrence of ASCII quotation mark.
The list of quotes to jump to is defined by `otrenav-ascii-quotes'.
See also: `otrenav-backward-quote'."
  (interactive)
  (search-forward-regexp (eval-when-compile (regexp-opt otrenav-ascii-quotes)) nil t))

(defun otrenav-backward-quote ()
  "Move cursor to the previous occurrence of ASCII quotation mark.
See `otrenav-forward-quote'."
  (interactive)
  (search-backward-regexp (eval-when-compile (regexp-opt otrenav-ascii-quotes)) nil t))

;;
;; Search sites
;;
(defun lookup-wikipedia ()
  "Look up the word under cursor in Wikipedia.
If there is a text selection (a phrase), use that.

This command switches you to your browser."
  (interactive)
  (let (myWord myUrl)
    (setq myWord
          (if (use-region-p)
              (buffer-substring-no-properties (region-beginning) (region-end))
            (thing-at-point 'symbol)))

    (setq myWord (replace-regexp-in-string " " "_" myWord))
    (setq myUrl (concat "http://en.wikipedia.org/wiki/" myWord))
    (browse-url myUrl)
    ))

(defun lookup-google ()
  "Look up the word under cursor in Google.
If there is a text selection (a phrase), use that.

This command switches you to your browser."
  (interactive)
  (let (myWord myUrl)
    (setq myWord
          (if (use-region-p)
              (buffer-substring-no-properties (region-beginning) (region-end))
            (thing-at-point 'symbol)))

    (setq myWord (replace-regexp-in-string " " "_" myWord))
    (setq myUrl (concat "http://www.google.com/search?q=" myWord))
    (browse-url myUrl)
    ))

(defun lookup-wolfram-alpha ()
  "Look up the word under cursor in Wolfram Alpha.
If there is a text selection (a phrase), use that.

This command switches you to your browser."
  (interactive)
  (let (myWord myUrl)
    (setq myWord
          (if (use-region-p)
              (buffer-substring-no-properties (region-beginning) (region-end))
            (thing-at-point 'symbol)))

    (setq myWord (replace-regexp-in-string " " "_" myWord))
    (setq myUrl (concat "http://www.wolframalpha.com/input/?i=" myWord))
    (browse-url myUrl)
    ))
;;
;; Word/phrase definitions
;;
(defun lookup-word-definition ()
  "Look up the current word's definition in a browser.
If a region is active (a phrase), lookup that phrase."
  (interactive)
  (let (myWord myUrl)
    (setq myWord
          (if (use-region-p)
              (buffer-substring-no-properties (region-beginning) (region-end))
            (thing-at-point 'symbol)))

    (setq myWord (replace-regexp-in-string " " "%20" myWord))
    (setq myUrl (concat "http://www.answers.com/main/ntquery?s=" myWord))

    (browse-url myUrl)
    ;; (w3m-browse-url myUrl) ;; if you want to browse using w3m
    ))

(global-set-key (kbd "<f6>") 'lookup-word-definition)
