;; Configure fonts by extending `home-fontconfig-service-type`, this
;; preserves the default values of this service.
(simple-service 'additional-fonts-service
                home-fontconfig-service-type
                (list
                    ;; Set Fira Code as default monospace font
                  '(alias
                     (family "monospace")
                     (prefer
                       (family "Fira Code")))))
