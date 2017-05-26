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
     (quote (magit git-gutter
	     evil evil-commentary evil-surround
	     badwolf-theme move-text
	     neotree))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
  )
;; ==================================
;; ======// AUTO-INSTALL PKGS //=====
(unless package-archive-contents
  (package-refresh-contents))
(package-install-selected-packages)
;; ==================================
;; =========// No - BACKUPS //=======
(setq make-backup-files nil) ; No backup~
(setq auto-save-default nil) ; No #autosave#
;; ==================================
;; ===========// STYLE //============
(tool-bar-mode -1)
(load-theme 'badwolf t)
(add-to-list 'default-frame-alist
                       '(font . "Source Code Pro-11"))
;; ==================================
;; ==========// CONFIG //============
(setq column-number-mode t)
(global-linum-mode t)
(global-git-gutter-mode t)
(git-gutter:linum-setup)
;; ==================================
;; ===========// EVIL //=============
(evil-mode t)
(setq evil-ex-search-case 'smart)
(evil-commentary-mode t)
(global-evil-surround-mode t)

(evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
(evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)

(define-key evil-normal-state-map (kbd "0") 'evil-first-non-blank)
(define-key evil-normal-state-map (kbd "M-k") 'move-text-up)
(define-key evil-normal-state-map (kbd "M-j") 'move-text-down)
(define-key evil-visual-state-map (kbd "M-k")
  (concat ":m '<-2" (kbd "RET") "gv=gv"))
(define-key evil-visual-state-map (kbd "M-j")
  (concat ":m '>+1" (kbd "RET") "gv=gv"))
;; ==================================
