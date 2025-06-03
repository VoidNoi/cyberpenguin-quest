;; Load the publishing system
(require 'ox-publish)

(require 'package)
(setq package-user-dir (expand-file-name "./.packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; Initialize the package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install dependencies
(package-install 'htmlize)

(setq org-html-validation-link nil
      org-html-head-include-scripts nil
      org-html-head-include-default-style nil
      org-html-htmlize-output-type 'css        ;;disables highlighting by htmlize
      org-html-head "<link rel=\"stylesheet\" href=\"style.css\" type=\"text/css\" />"
      org-html-preamble t
      org-html-preamble-format '(("en" "
<header>
<h1>This is a header</h1>
<nav>
<a class='nav-link' href=''>Home</a>
<a class='nav-link' href='guides'>Guides</a>
<a class='nav-link' href='recipes'>Recipes</a>
<a class='nav-link' href='about'>About</a>
</nav>
</header>"))
      )

;; Define the publishing project
(setq org-publish-project-alist
      '(("cyberpenguin-quest:main"
             :recursive t
             :base-extension "org"
             :base-directory "./content"
             :publishing-function org-html-publish-to-html
             :publishing-directory "./public"
             :with-author nil
             :with-creator nil
             :with-title t
             :with-toc nil
             :section-numbers nil
             :time-stamp-file nil
             )
        ("cyberpenguin-quest:assets"
         :base-directory "./assets"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|woff2\\|ttf\\|otf\\|zip"
         :publishing-directory "./public"
         :recursive t
         :publishing-function org-publish-attachment)
        ))

;; Generate the site output
(org-publish-all t)

(message "Build complete!")
