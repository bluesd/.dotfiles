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
            ivy counsel
            projectile ag
            flycheck
            auto-complete
         ;; === Modes
            web-mode emmet-mode
            php-mode
            groovy-mode
            js2-mode json-mode
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
                       '(font . "Source Code Pro-11"))

;; ==========// CONFIG //============
(setq column-number-mode t)
(global-linum-mode t)
(setq-default fill-column 80)
(setq-default indent-tabs-mode nil)
(setq tab-stop-list (number-sequence 2 120 2))
;; ------ Encoding
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
(set-keyboard-coding-system 'utf-8-unix)
(set-selection-coding-system 'utf-8-unix)
(setq-default buffer-file-coding-system 'utf-8-unix)

;; ===========// EVIL //=============
(require 'evil)
(evil-mode t)
(setq evil-ex-search-case 'smart)
(evil-commentary-mode t)
(global-evil-surround-mode t)
(global-evil-leader-mode t)
(evil-leader/set-leader "<SPC>")
(define-key evil-normal-state-map (kbd "0") 'evil-first-non-blank)
(define-key evil-normal-state-map (kbd "M-k") 'move-text-up)
(define-key evil-normal-state-map (kbd "M-j") 'move-text-down)
(define-key evil-visual-state-map (kbd "M-k")
  (concat ":m '<-2" (kbd "RET") "gv=gv"))
(define-key evil-visual-state-map (kbd "M-j")
  (concat ":m '>+1" (kbd "RET") "gv=gv"))

;; ==========// PLUGINS //===========
;; ------ General
(evil-leader/set-key "<SPC>" 'execute-extended-command)
;; ------ Auto-Complete
(ac-config-default)
(global-auto-complete-mode t)
;; ------ FillColumn
(require 'fill-column-indicator)
;;(setq fci-rule-image-format 'pbm)
(setq fci-rule-width 2)
(setq fci-rule-color "#83A598")
(evil-leader/set-key "ci" 'fci-mode)
;; ------ SmoothScroll
(smooth-scrolling-mode t)
(setq smooth-scroll-margin 5)
;; ------ NeoTree
(require 'neotree)
(setq neo-theme 'nerd)
(setq neo-window-width 25)
(evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
(evil-define-key 'normal neotree-mode-map (kbd "r") 'neotree-change-root)
(evil-define-key 'normal neotree-mode-map (kbd "p") 'neotree-select-up-node)
(evil-define-key 'normal neotree-mode-map (kbd "H") 'neotree-hidden-file-toggle)
(evil-define-key 'normal neotree-mode-map (kbd "R") 'neotree-refresh)
(evil-leader/set-key "t" 'neotree-toggle)
;; ------ RainbowDelimiters
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
;; ------ GitGutter
(global-git-gutter-mode t)
(git-gutter:linum-setup)
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
;; ------ Org-Mode
(add-hook 'org-mode-hook 'org-indent-mode)
;; ------ Diminish
(eval-after-load "evil-commentary"
  '(diminish 'evil-commentary-mode))
(eval-after-load "git-gutter"
  '(diminish 'git-gutter-mode))
(eval-after-load "undo-tree"
  '(diminish 'undo-tree-mode))
(eval-after-load "ivy"
  '(diminish 'ivy-mode))
(eval-after-load "auto-complete"
  '(diminish 'auto-complete-mode))
(eval-after-load "flycheck"
  '(diminish 'flycheck-mode))
(diminish 'abbrev-mode)
;; ------ Avy
(require 'avy)
(setq avy-style 'at-full)
(setq avy-background t)
(evil-leader/set-key "jl" 'avy-goto-line)
(evil-leader/set-key "jc" 'avy-goto-char)
;; ------ Ivy
(ivy-mode t)
;; ------ Magit
(evil-leader/set-key "gs" 'magit-status)
;; ------ Projectile
(evil-leader/set-key "pf" 'projectile-find-file)
(evil-leader/set-key "ps" 'projectile-ag)
;; ------ Emmet
(add-hook 'sgml-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook  'emmet-mode)
;; ------ JS2
(require 'js2-mode)
(setq js2-mode-show-parse-errors nil)
(setq js2-mode-show-strict-warnings nil)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.jsx$'" . js2-jsx-mode))
(add-hook 'js2-mode-hook (lambda () (setq js2-basic-offset 2)))
;; ------ FlyCheck
(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)
(flycheck-add-mode 'javascript-eslint 'js2-mode)
