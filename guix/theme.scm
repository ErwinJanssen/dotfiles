(use-modules (json))

;; Define the different shades of each color
(define colors `(
  (normal
    (black . "#333333")
    (red . "#bf5f61")
    (green . "#6bb26b")
    (yellow . "#e5c689")
    (blue . "#8eadcc")
    (magenta . "#b499ff")
    (cyan . "#7acccc")
    (white . "#bfc7d5")
    )

  (bright
    (black . "#595959")
    (red . "#f2484b")
    (green . "#3dcc3d")
    (yellow . "#ffff4c")
    (blue . "#5ba0e5")
    (magenta . "#a54cff")
    (cyan . "#2de5e5")
    (white . "#e5eeff")
    )

  (dim
    (black . "#262626")
    (red . "#661919")
    (green . "#1f3f1f")
    (blue . "#1e4266")
    (magenta . "#362d4c")
    )

  (dimmer
    (black . "#1a1a1a")
    )
  ))

;; Utility function to get a specific color by shade and name
(define (get-color color-shade color-name)
  (assoc-ref (assoc-ref colors color-shade) color-name))

;; Provide some high level color definitions such as which color is the accent
;; color.
(define theme `(
  (normal
    (background . ,(get-color 'dim 'black))
    (foreground . ,(get-color 'normal 'white))
    (accent . ,(get-color 'normal 'magenta))
    (match . ,(get-color 'normal 'green))
    (urgent . ,(get-color 'dim 'red))
    (success . ,(get-color 'normal 'green))
    (warning . ,(get-color 'normal 'yellow))
    (error . ,(get-color 'normal 'red))
    )

  (bright
    (background . ,(get-color 'normal 'black))
    (foreground . ,(get-color 'bright 'white))
    (accent . ,(get-color 'bright 'magenta))
    (match . ,(get-color 'bright 'green))
    )

  (brighter
    (background . ,(get-color 'bright 'black))
    )

  (dim
    (background . ,(get-color 'dimmer 'black))
    (accent . ,(get-color 'dim 'magenta))
    )
    ))

;; Utility function to get a theme color by shade and name
(define (get-theme theme-shade theme-name)
  (assoc-ref (assoc-ref theme theme-shade) theme-name))

;; Given the theme colors, provide some concrete definitions for UI elements.
;; These descriptive names can be used in the appropriate places.
(define ui `(
  (window
    (border
      (normal . ,(get-theme 'dim 'accent))
      (bright . ,(get-theme 'normal 'accent))
      )
    )

  (search
    (default
      (background . ,(get-theme 'normal 'background))
      (foreground . ,(get-theme 'normal 'foreground))
      )
    (input
      (background . ,(get-theme 'dim 'accent))
      (foreground . ,(get-theme 'normal 'foreground))
      )
    (selected
      (background . ,(get-theme 'brighter 'background))
      (foreground . ,(get-theme 'normal 'accent))
      (match . ,(get-theme 'bright 'match))
      )
    (item
      (background . ,(get-theme 'bright 'background))
      (match . ,(get-theme 'normal 'match))
      )
    )

  (status_bar
    (default
      (background . ,(get-theme 'bright 'background))
      (foreground . ,(get-theme 'normal 'foreground))
      )
    (tab
      (background . ,(get-theme 'bright 'background))
      (foreground . ,(get-theme 'normal 'foreground))
      )
    (active
      (background . ,(get-theme 'normal 'accent))
      (foreground . ,(get-theme 'dim 'accent))
      )
    (urgent
      (background . ,(get-theme 'normal 'urgent))
      (foreground . ,(get-theme 'normal 'foreground))
      )
    )
      ))

;; Utility function to get a UI color by element and property
(define (get-ui ui-element ui-component ui-property)
  (assoc-ref (assoc-ref (assoc-ref ui ui-element) ui-component) ui-property))

;; Return an alist with all color definitions combined
`(
  (colors . ,colors)
  (theme . ,theme)
  (ui . ,ui)
  )
