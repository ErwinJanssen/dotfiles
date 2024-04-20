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
  (guix gexp)
  )

;; These packages will be installed and show up in the 'Home' profile, under
;; `~/.guix-home/profile`. Some loaded file services might append to this list.
(define %user-packages (list
  ;; Locale data
  "glibc-locales"
  ))

;; Utility function to easily append a package for this home configuration.
(define (add-user-package package-name)
  (set! %user-packages (append %user-packages (list package-name))))

;; Services used to configure the Home profile. Loaded service files will
;; append their services here.
(define %user-services (list
  (simple-service 'additional-guix-environment-variables
                  home-environment-variables-service-type
                  `(("GUIX_LOCPATH" . "$HOME/.guix-home/profile/lib/locale")))
  ))

;; Utility function to easily append a service for this home configuration.
(define (add-user-service service-definition)
  (set! %user-services (append %user-services (list service-definition))))

(home-environment
  (packages (specifications->packages %user-packages))
  (services %user-services))
