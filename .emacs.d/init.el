;; ============// PKGS //============
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
  '(package-selected-packages
    (quote (darktooth-theme spaceline diminish
            rainbow-delimiters
            smooth-scrolling
            neotree
            fill-column-indicator
            evil evil-leader evil-commentary evil-surround
            avy move-text
            magit git-gutter
            ivy
            projectile
         ;; === Modes
            web-mode emmet-mode
            php-mode
            js2-mode
            groovy-mode
	    ))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(avy-lead-face ((t (:foreground "#FB4933" :weight bold))))
 '(avy-lead-face-0 ((t (:foreground "#3FD7E5" :weight bold))))
 )

;; ======// AUTO-INSTALL PKGS //=====
(unless package-archive-contents
  (package-refresh-contents))
(package-install-selected-packages)

;; =========// NO - BACKUPS //=======
(setq make-backup-files nil) ; No backup~
(setq auto-save-default nil) ; No #autosave#

;; ===========// STYLE //============
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
;(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(load-theme 'darktooth t)
(add-to-list 'default-frame-alist
                       '(font . "Source Code Pro-10"))

;; ==========// CONFIG //============
(setq-default fill-column 80)
(setq-default indent-tabs-mode nil)
(setq column-number-mode t)
;; (global-linum-mode t)

;; ==========// SYNTAX //============
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

;; ===========// EVIL //=============
(evil-mode t)
(global-evil-leader-mode t)
(evil-leader/set-leader "<SPC>")
(setq evil-ex-search-case 'smart)
(evil-commentary-mode t)
(global-evil-surround-mode t)

(define-key evil-normal-state-map (kbd "0") 'evil-first-non-blank)
(define-key evil-normal-state-map (kbd "M-k") 'move-text-up)
(define-key evil-normal-state-map (kbd "M-j") 'move-text-down)
(define-key evil-visual-state-map (kbd "M-k")
  (concat ":m '<-2" (kbd "RET") "gv=gv"))
(define-key evil-visual-state-map (kbd "M-j")
  (concat ":m '>+1" (kbd "RET") "gv=gv"))

;; ==========// PLUGINS //===========
;; ------ FillColumn
;;(setq fci-rule-image-format 'pbm)
(setq fci-rule-width 2)
(setq fci-rule-color "#83A598")
;; ------ SmoothScroll
(smooth-scrolling-mode t)
(setq smooth-scroll-margin 5)
;; ------ NeoTree
(setq neo-theme 'nerd)
(setq neo-window-width 25)
(evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
(evil-define-key 'normal neotree-mode-map (kbd "r") 'neotree-change-root)
(evil-define-key 'normal neotree-mode-map (kbd "p") 'neotree-select-up-node)
(evil-leader/set-key "SPC" 'neotree-toggle)
;; ------ RainbowDelimiters
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
;; ------ GitGutter
(global-git-gutter-mode t)
;; (git-gutter:linum-setup)
;; ------ Spaceline
(require 'spaceline-config)
(spaceline-spacemacs-theme)
(setq powerline-default-separator 'bar)
(setq spaceline-highlight-face-func 'spaceline-highlight-face-evil-state)
(set-face-attribute 'spaceline-evil-emacs nil :background "#be84ff")
(set-face-attribute 'spaceline-evil-insert nil :background "#5fd7ff")
(set-face-attribute 'spaceline-evil-motion nil :background "#ae81ff")
(set-face-attribute 'spaceline-evil-normal nil :background "#a6e22e")
(set-face-attribute 'spaceline-evil-replace nil :background "#f92672")
(set-face-attribute 'spaceline-evil-visual nil :background "#fd971f")
(setq spaceline-buffer-size-p nil)
(setq spaceline-buffer-encoding-abbrev-p nil)
(setq spaceline-hud-p nil)
(spaceline-compile)
;; ------ Diminish
(eval-after-load "evil-commentary"
  '(diminish 'evil-commentary-mode))
(eval-after-load "git-gutter"
  '(diminish 'git-gutter-mode))
(eval-after-load "undo-tree"
  '(diminish 'undo-tree-mode))
(eval-after-load "ivy"
  '(diminish 'ivy-mode))
(diminish 'abbrev-mode)
;; ------ Avy
(setq avy-style 'at-full)
(setq avy-background t)
(evil-leader/set-key "j" 'avy-goto-line)
;; ------ Ivy
(ivy-mode t)
;; ------ Projectile
(evil-leader/set-key "pj" 'projectile-find-file)
;; ------ Emmet
(add-hook 'sgml-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook  'emmet-mode)
