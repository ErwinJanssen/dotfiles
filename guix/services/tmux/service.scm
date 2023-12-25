(add-user-package "tmux")

(add-user-service (simple-service 'ripgrep-config
  home-files-service-type
  `((".tmux.conf" ,(local-file "generated/tmux.conf")))))
