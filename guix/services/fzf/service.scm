(add-user-package "fzf")

(define fzf-default-opts
  (string-join
    (list
      "--ansi"
      (string-append "--color=fg+:" (get-ui 'search 'selected 'foreground))
      "--color=bg+:-1"
      (string-append "--color=hl+:" (get-ui 'search 'selected 'match))
      "--color=bg:-1"
      (string-append "--color=hl:" (get-ui 'search 'item 'match))
      (string-append "--color=prompt:" (get-ui 'search 'input 'foreground))
      (string-append "--color=pointer:" (get-ui 'search 'selected 'foreground))
      (string-append "--color=marker:" (get-ui 'search 'selected 'match))
    )
    " "))

(add-user-service (simple-service 'fzf-environment-variables
  home-environment-variables-service-type
  `(
    ("FZF_DEFAULT_OPTS" . ,fzf-default-opts)
    ("FZF_DEFAULT_COMMAND" . "fd --type file --hidden --exclude .git --strip-cwd-prefix")
    ("FZF_CTRL_T_COMMAND". ,(literal-string "command fd --unrestricted --search-path $dir --exclude .git"))
    )))


(add-user-service (simple-service 'fzf-fish-config
  home-fish-service-type
  (home-fish-extension
    (config (list (local-file "config.fish"
              ))))))
