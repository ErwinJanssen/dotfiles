(add-user-package "tmux")

(add-user-service (simple-service 'tmux-config
  home-files-service-type
  `((".tmux.conf" ,(local-file "generated/tmux.conf")))))
