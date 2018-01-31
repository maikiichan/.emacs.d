(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
	      (expand-file-name (concat user-emacs-directory path))))
	(add-to-list `load-path default-directory)
	(if (fboundp `normal-top-level-add-subdirs-to-load-path)
	    (normal-top-level-add-subdirs-to-load-path))))))

(add-to-load-path "elisp" "conf" "public_repos")

(require 'package)
(add-to-list
 'package-archives
 '("marmalade" . "https://marmalade-repo.org/packages/") t)
(add-to-list
 'package-archives
 '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

(when window-system
  (tool-bar-mode 0)
  (scroll-bar-mode 0)
  (menu-bar-mode 0))

;;キーバインド
(global-set-key (kbd "C-m") 'newline-and-indent)
(define-key global-map (kbd "C-c l") 'toggle-truncate-lines)
(define-key global-map (kbd "C-t") 'other-window)
(setq inhibit-startup-message t)
(setq make-backup-file nil)
(blink-cursor-mode 0)
(global-hl-line-mode t)

;;パス設定
(add-to-list 'exec-path "/usr/local/bin")

;;文字コード設定
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)

;;;;フレーム設定
;;カラム番号を表示
(column-number-mode t)
(size-indication-mode t)
(setq display-time-day-and-date t)
(setq display-time-24hr-format t)
(display-time-mode t)
(display-battery-mode t)
(setq frame-title-format "%f")
(global-linum-mode 0)

;;font settings
(set-face-attribute 'default nil :family "Cica" :height 130)
															
;;tab setting
(setq-default tab-width 4)

(setq show-paren-delay 0)
(show-paren-mode t)

(global-auto-revert-mode t)
(setq make-backup-files nil)
(setq auto-save-default nil)

(add-hook 'after-save-hook
		  'executable-make-buffer-file-executable-if-script-p)

(defun elisp-mode-hooks ()
  "lisp-mode-hooks"
  (when (require 'eldoc nil t)
	(setq eldoc-idle-delay 0.2)
	(setq eldoc-echo-are-use-multiline-p t)
	(turn-on-eldoc-mode)))
(add-hook 'emacs-lisp-mode-hool 'elisp-mode-hooks)

;;Theme setting
(load-theme 'solarized-dark t)

;;ivy/counsel settings
(ivy-mode 1)

;; company
(require 'company)
(global-company-mode t)
;; (company-quickhelp-mode nil)
(define-key company-active-map (kbd "M-n") nil)
(define-key company-active-map (kbd "M-p") nil)
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-active-map (kbd "C-h") nil)
  
;;color-moccur settings
(when (require 'color-moccur nil t)
  (define-key global-map (kbd "M-o") 'occur-by-moccur)
  (setq moccur-split-word t)
  (add-to-list 'dmoccur-exclusion-mask "\\.DS_Store")
  (add-to-list 'dmoccur-exclusion-mask "^#.+#$"))


;;wgrep settings
(require 'wgrep nil t)

;;undohist settings
(when (require 'undohist nil t)
  (undohist-initialize))

;;point-undo settings
(when (require 'point-undo nil t)
  (define-key global-map (kbd "M-[") 'point-undo)
  (define-key global-map (kbd "M-]") 'point-redo))

;;elscreen settings
(setq elscreen-prefix-key (kbd "C-t"))
(when (require 'elscreen nil t)
  (elscreen-start))

;;cua-mode settigs
(cua-mode t)
(setq cua-enable-cua-keys nil)

;;php-mode settings
(when (require 'php-mode nil t)
  (setq php-site-url "https://secure.php.net/"
		php-manual-url 'ja))

;;ruby-mode settings
(add-hook 'ruby-mode-hook #'ruby-electric-mode)

;;python-mode settings
(setq python-check-command "flake8")

;;flycheck-settings
(add-hook 'after-init-hook #'global-flycheck-mode)
(with-eval-after-load 'flycheck
  (flycheck-pos-tip-mode))

;;ac-emoji settings
(when (require 'ac-emoji nil t)
  (add-to-list 'ac-modes 'text-mode)
  (add-to-list 'ac-modes 'markdown-mode)
  (add-hook 'text-mode-hook 'ac-emoji-setup)
  (add-hook 'markdown-mode-hook 'ac-emoji-setup))

;;git-gutter settings
(when (require 'git-gutter nil t)
  (global-git-gutter-mode t))

;;multi-term settings
(when (require 'multi-term nil t)
  (setq multi-term-program shell-file-name))
(global-set-key (kbd "C-c t") 'multi-term)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(multiple-cursors swiper-helm counsel company-quickhelp company git-gutter magit ac-emoji quickrun flycheck inf-ruby ruby-electric yaml-mode php-mode elscreen point-undo undohist wgrep color-moccur auto-complete helm zenburn-theme multi-term)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
