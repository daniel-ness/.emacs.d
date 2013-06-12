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

   (:name buffer-move			; have to add your own keys
	  :after (progn
		   (global-set-key (kbd "M-<up>")     'buf-move-up)
		   (global-set-key (kbd "M-<down>")   'buf-move-down)
		   (global-set-key (kbd "M-<left>")   'buf-move-left)
		   (global-set-key (kbd "M-<right>")  'buf-move-right)))

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
                         '(("php"    . "\\.phtml\\'")))
                   (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
                   (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
                   (add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
                   (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
                   (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
                   (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
                   (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
                   (setq web-mode-code-indent-offset 4)))

   (:name color-theme-papercup
          :type git
          :url "git@github.com:daniel-ness/papercup-theme.git"
          :load "papercup-theme.el"
          :compile ("papercup-theme.el")
          :features color-theme-papercup
          :after (progn
                   (color-theme-papercup)))

   ))


;; now set our own packages
(setq
 my:el-get-packages
 '(el-get				; el-get is self-hosting
   anything
   auto-complete			; complete as you type with overlays
   ac-python
   buffer-move
   color-theme		                ; nice looking emacs
   color-theme-papercup
   git-modeline
   smex                                 ; ido-based file finder
   switch-window			; takes over C-x o
   php-mode-improved			; if you're into php...
   php-completion
   flyphpcs
   web-mode
   yasnippet
   yaml-mode
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


;; hooks
(add-hook 'php-mode-hook
          '(lambda ()
             (setq c-basic-offset 4) ; 2 tabs indenting
             (setq fill-column 78)
             (c-set-offset 'case-label '+)
             (c-set-offset 'arglist-close 'c-lineup-arglist-operators)
             (c-set-offset 'arglist-intro '+) ; for FAPI arrays and DBTNG
             (c-set-offset 'arglist-cont-nonempty 'c-lineup-math) ; for DBTNG fields and values
             (web-mode)
             ))

(add-hook 'web-mode-hook
          '(lambda ()
             (flymake-mode)))








