(setq user-init-file "/tmp/.emacs")

;; Marmalade: http://marmalade-repo.org/
(require 'package)
(add-to-list 'package-archives
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(package-initialize)

(package-refresh-contents)

(defvar my-packages
  '(
;    clj-refactor
    color-theme
    dash
    gh
    gist
    multiple-cursors
    magit
    cider
    pkg-info
    ruby-mode
    smex
    typopunct
    yasnippet
    org
    markdown-mode
    ))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))
