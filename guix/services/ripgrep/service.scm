(add-user-package "ripgrep")

(add-user-service (simple-service 'ripgrep-environment-variables
  home-environment-variables-service-type
  `(("RIPGREP_CONFIG_PATH" . "$HOME/.config/ripgrep/config"))))

(add-user-service (simple-service 'ripgrep-config
  home-xdg-configuration-files-service-type
  `(("ripgrep/config" ,(local-file "config")))))
