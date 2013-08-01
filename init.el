(require 'package)
(add-to-list 'package-archives
             '("marmalade" . 
               "http://marmalade-repo.org/packages/"))
(package-initialize)

;;(when (require 'flyphpcs)
;;  (setq fly/phpcs-phpcs-dir "~/.emacs.d/manual/PHP_CodeSniffer-1.5.0RC2")
;;  (setq fly/phpcs-phpexe "/usr/bin/php")
;;  )

;; initialise el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil t)
  (url-retrieve
   "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
   (lambda (s)
     (end-of-buffer)
     (eval-print-last-sexp))))

;;-------------- some startup display options --------------------;;
(setq inhibit-startup-message t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-linum-mode)

(setq-default indent-tabs-mode nil)
(put 'scroll-left 'disabled -1)
(show-paren-mode t)

(add-to-list 'default-frame-alist '(font . "Inconsolata-12"))

; temporary file management
(setq temporary-file-directory "/tmp/emacs.bk")
(setq backup-directory-alist
	`((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
        `((".*" ,temporary-file-directory t)))
;;----------------------------------------------------------------;;

(setq
 el-get-sources
 '(
   (:name auto-complete
          :after (progn
                   (require 'auto-complete)
                   (global-auto-complete-mode t)))

   (:name js2-mode
          :after (progn
                   (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))))

   (:name smex				; a better (ido like) M-x
	  :after (progn
		   (setq smex-save-file "~/.emacs.d/.smex-items")
		   (global-set-key (kbd "M-x") 'smex)
		   (global-set-key (kbd "M-X") 'smex-major-mode-commands)))

   (:name magit				; git meet emacs, and a binding
	  :after (progn
		   (global-set-key (kbd "C-x C-z") 'magit-status)))

   (:name goto-last-change		; move pointer back to last change
	  :after (progn
		   ;; when using AZERTY keyboard, consider C-x C-_
		   (global-set-key (kbd "C-x C-/") 'goto-last-change)))

   (:name web-mode  
          :type git  
          :url "git://github.com/fxbois/web-mode.git"  
          :load "web-mode.el"  
          :compile ("web-mode.el")  
          :features web-mode
          :after (progn
                   (setq web-mode-engines-alist
                         '(("php" . "\\.phtml\\'")
                           ("php" . "\\.html\twig\\'")
                           ("jinja" . "\\.jinja.html\\'")
                           ))
                   (add-to-list 'auto-mode-alist '("\\.html.twig\\'" . web-mode))
                   (add-to-list 'auto-mode-alist '("\\.xml\\'" . web-mode))
                   (add-to-list 'auto-mode-alist '("\\.jinja.html\\'" . web-mode))
                   (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
                   (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
                   (add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
                   (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
                   (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
                   (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
                   (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
                   (setq web-mode-code-indent-offset 4)))

   (:name soothe-theme
          :type git
          :url "git://github.com/jasonm23/emacs-soothe-theme.git"
          :load "soothe-theme.el"
          :compile ("soothe-theme.el")
          :after (progn
                   (load-theme 'soothe t)))

   (:name git-gutter+
          :type git
          :url "git://github.com/nonsequitur/git-gutter-plus.git",
          :load "git-gutter+.el"
          :compile ("git-gutter+.el")
          :after (progn
                   ;(global-git-gutter+-mode t)

                   (global-set-key (kbd "C-x n") 'git-gutter+-next-hunk)
                   (global-set-key (kbd "C-x p") 'git-gutter+-previous-hunk)

                   (global-set-key (kbd "C-x v =") 'git-gutter+-popup-hunk)
                   (global-set-key (kbd "C-x r") 'git-gutter+-revert-hunk)

                   (global-set-key (kbd "C-x t") 'git-gutter+-stage-hunks)
                   (global-set-key (kbd "C-x c") 'git-gutter+-commit)
                   (global-set-key (kbd "C-x C") 'git-gutter+-stage-and-commit)

                   (global-set-key (kbd "C-x C-g") 'git-gutter+-mode) 
                   ;(global-set-key (kbd "C-x G") 'global-git-gutter+-mode)
                   ))
   ))


;; now set our own packages
(setq
 my:el-get-packages
 '(el-get				; el-get is self-hosting
   android-mode
   anything
   auto-complete			; complete as you type with overlays
   ac-python
   ;buffer-move
   color-theme		                ; nice looking emacs
   git-modeline
   ipython
   js2-mode
   psvn
   ;git-gutter+
   markdown-mode
   smex                                 ; ido-based file finder
   switch-window			; takes over C-x o
   php-mode
   php-doc
   ;php-mode-improved			; if you're into php...
   php-completion
   pretty-mode
   pymacs
   python-pep8
   rainbow-mode
   redspace
   flymake-cursor
   flymake-extension
   flymake-html-validator
   soothe-theme
   todostack
   twitter
   smarttabs
   web-mode
   yasnippet
   yaml-mode
   webjump++
   zencoding-mode
   ))

(el-get 'sync my:el-get-packages)


;; load manual plugins
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

(add-to-list 'load-path "~/.emacs.d/manual/magit-1.2.0")
(require 'magit)
(eval-after-load 'magit
  '(progn
     ;; diff colour-scheme
     (set-face-foreground 'magit-diff-add "#EAFFA2")
     (set-face-foreground 'magit-diff-del "#FFA5A2")
     (set-face-foreground 'magit-diff-none "#777777")
     (set-face-background 'magit-item-highlight "#444444")))
(global-set-key (kbd"C-x g") 'magit-status)


;; file finder
(ido-mode t)
(setq ido-enable-flex-matching t)

;; window navigation
(global-set-key (kbd "M-<up>")     'windmove-up)
(global-set-key (kbd "M-<down>")   'windmove-down)
(global-set-key (kbd "M-<left>")   'windmove-left)
(global-set-key (kbd "M-<right>")  'windmove-right)

;; hooks
(add-hook 'php-mode-hook
          '(lambda ()
             (setq c-basic-offset 4) ; 2 tabs indenting
             (setq fill-column 78)
             (local-set-key (kbd "RET") 'newline-and-indent)
             (c-set-offset 'case-label '+)
             (c-set-offset 'arglist-close 'c-lineup-arglist-operators)
             (c-set-offset 'arglist-intro '+) ; for FAPI arrays and DBTNG
             (c-set-offset 'arglist-cont-nonempty 'c-lineup-math) ; for DBTNG fields and values
             (flyphpcs)
             (flymake-mode)
             ))
