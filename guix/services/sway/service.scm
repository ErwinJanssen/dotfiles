(add-user-service (simple-service 'sway-fish-config
  home-fish-service-type
  (home-fish-extension
    (config (list (local-file "config.fish"
              ))))))
