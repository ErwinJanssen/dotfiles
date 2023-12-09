;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of the Home profile.
;;
;; Note from `guix import`:
;;
;;  "This is "symbolic": it only specifies package names. To reproduce the
;;  exact same profile, you also need to capture the channels being used, as
;;  returned by "guix describe". See the "Replicating Guix" section in the
;;  manual.

(use-modules
  (gnu home)
  (gnu packages)
  (gnu services)
  (gnu home services)
  (gnu home services fontutils)
  (gnu home services shells)
  )

(home-environment
  ;; These packages will be installed and show up in the 'Home' profile, under
  ;; `~/.guix-home/profile`.
  (packages (specifications->packages (list
    ;; Locale data
    "glibc-locales"

    ;; Preferred monospace font
    "font-fira-code"
  )))

  ;; Services used to configure the Home profile
  (services (list
    (simple-service 'additional-guix-environment-variables
                    home-environment-variables-service-type
                    `(("GUIX_LOCPATH" . "$HOME/.guix-home/profile/lib/locale")))
    (load "services/fontconfig.scm")
    (load "services/inputrc.scm")
    (service home-fish-service-type)
  )))
