(add-user-package "i3status")

(add-user-service (simple-service 'sway-fish-config
  home-fish-service-type
  (home-fish-extension
    (config (list (local-file "config.fish"
              ))))))

(add-user-service (simple-service 'i3status-config
  home-xdg-configuration-files-service-type
  `(("i3status/config" ,(local-file "generated/i3status/config")))))
