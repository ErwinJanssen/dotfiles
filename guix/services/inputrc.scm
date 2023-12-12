;; Configure readline behavior via `.inputrc`.
(add-user-service (service home-inputrc-service-type (home-inputrc-configuration
  (key-bindings `(
    ;; Use the up/down arrows to search through the history for partial
    ;; matches. This search behavior is similar to that of the Fish
    ;; shell.
    ("\"\\e[B\"" . "history-substring-search-forward")
    ("\"\\e[A\"" . "history-substring-search-backward")

    ;; Instead of the default auto complete that completes up to
    ;; a common prefix, cycle through the list of possibilities
    ;; completions.
    ("Tab" . "menu-complete")
    ))

  (variables `(
    ;; When performing completion, highlight the matched prefix of the
    ;; suggestions
    ("colored-completion-prefix" . #t)

    ;; Do not immediately cycle through the list when auto completing,
    ;; but first show the common prefix of all possibilities.
    ("menu-complete-display-prefix" . #t)

    ;; If there are multiple options for auto completing, show all
    ;; available matches.
    ("show-all-if-ambiguous" . #t)

    ;; Perform filename matching and completion in a case-insensitive
    ;; fashion.
    ("completion-ignore-case" . #t)

    ;; In addition to case-insensitivity, treat hyphens (-) and
    ;; underscores (_) as equivalent for filename matching and
    ;; completion.
    ("completion-map-case" . #t)
    ))

  (conditional-constructs `(
    ;; Include system defaults
    ("$include" . "/etc/inputrc")
    ))
  )))
