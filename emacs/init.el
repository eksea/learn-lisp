;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(when (>= emacs-major-version 24)
  (message "update package archives")
  (require 'package)
  (package-initialize)
  (setq package-archives '(("gnu" . "http://elpa.emacs-china.org/gnu/")
               ("melpa" . "http://elpa.emacs-china.org/melpa/"))))

(require 'cl)

(defvar eksea/packages '(
			 company
			 monokai-theme
			 go-mode
			 darkokai-theme
			 swiper
			 counsel
			 smartparens
			 neotree
			 all-the-icons
			 ) "Default packages")

(setq package-selected-packages eksea/packages)

(defun eksea/packages-installed-p ()
  (loop for pkg in eksea/packages
	when (not (package-installed-p pkg)) do (return nil)
	finally (return t)))

(unless (eksea/packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg eksea/packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))

;;(load-theme 'monokai t)
(load-theme 'darkokai t)

;; config swiper
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-h f") 'counsel-describe-function)
(global-set-key (kbd "C-h v") 'counsel-describe-variable)

;; config neotree
(require 'neotree)
(global-set-key (kbd "<f3>") 'neotree-toggle)
(setq neo-smart-open 1)
;;(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
;;(setq projectile-switch-project-action 'neotree-projectile-action)

;; close tool bar
(tool-bar-mode -1)

;; close scroll bar
(scroll-bar-mode -1)

;; show line number
(global-linum-mode 1)

;; disable backup file
(setq make-backup-files nil)

;; close splash screen
(setq inhibit-splash-screen 1)

;; customize cursor style
(setq-default cursor-type 'bar)

;; close auto-indent
;; (electric-indent-mode -1)

;; customize font-size
(set-face-attribute 'default nil :height 160)

;; customize font-family
;; (set-default-font "Anonymous Pro")

;; open init file
(defun open-init-file()
  (interactive)
  (find-file "c:/Users/Jack/AppData/Roaming/.emacs.d/init.el"))

;; bind open-init-file to <f2>
(global-set-key (kbd "<f2>") 'open-init-file)

;; enable company
(global-company-mode t)

;; open recently edited files
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 26)
;; bind shortcut for recentf
(global-set-key (kbd "C-x C-r") 'recentf-open-files)

(delete-selection-mode t)

(require 'smartparens-config)
(smartparens-global-mode t)

;; enter fullscreen when launch up
(setq initial-frame-alist (quote ((fullscreen . maximized))))

(require 'org)
(setq org-src-fontify-natively t)

(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-idle-delay 0.08)
 '(company-minimum-prefix-length 1))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
