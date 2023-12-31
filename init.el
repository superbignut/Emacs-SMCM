;; -*- lexical-binding: t; -*-

;;Open the menu-bar, which is useful for novice(me).
;;(menu-bar-mode -1)

;;Close the tool-bar.
(tool-bar-mode -1)

;;Close the scroll-bar.
(scroll-bar-mode -1)

;;Enable the absolute line-numbers for all mode.
(global-display-line-numbers-mode 1)

;;Set the cursor-type to bar-like.
(setq-default cursor-type 'bar)
;;
(put 'narrow-to-region 'disabled nil)

;;
(defun open-init-file()
  "Bind f2 to open init.el file , useful!!!."
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(global-set-key (kbd "<f2>") 'open-init-file)

(global-set-key (kbd "C-h C-f") 'find-function)

(global-set-key (kbd "M-[") 'previous-buffer)

(global-set-key (kbd "M-]") 'next-buffer)

;;Non-nil inhibit the startup screen.
(setq inhibit-startup-screen -1)

;;Add folder:~/.emacs.d/lisp to the load-path.
(add-to-list 'load-path
	     (expand-file-name (concat user-emacs-directory "lisp")))
;;Set custom setting file.
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

;;Change sources from gnu to tsinghua.
(setq package-archives '(
			 ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
			 ("gnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
			 ("org" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")))

;;Load the FEATURE 'package in package.el.
(require 'package)

;;Initialize packages.
(unless (bound-and-true-p package--initialized)
  (package-initialize))

;;Update like sudo apt undate.
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


(package-install 'marginalia)
(marginalia-mode 1)

;; (package-install 'helm-ag)

;;Load FEATURE use-package.
(require 'use-package)

;;Set the packages installed automatically if not already present.
(setq use-package-always-ensure t)

;Use package helm for searching intelligently in minibuffer.
(use-package helm
  :bind (("M-x" . helm-M-x)
	 ("C-x C-f" . helm-find-files))
  ;;Alought helm-mode is setted, we still need to config two binds before.
  :init
  (helm-mode 1))

;;Use package company for complete-anything.
(use-package company
  :hook(after-init . global-company-mode);
  :config
  (setq  company-minimum-prefix-length 1;How many characters was typed before complete.
	 company-idle-delay 0.1;Time to delay before complete.
	 company-tooltip-align-annotations t;Annotations align at right.
	 company-tooltip-limit 20;Maximum number of the candidates.
	 company-show-quick-access t));Use M-[num] to access candidates quickly.

;;Use package flycheck for syntax checking.
(use-package flycheck
  :init (global-flycheck-mode)
  :config
  ;; flycheck-load-path need to be set the same as the 'load-path.
  (setq-default flycheck-emacs-lisp-load-path 'inherit))

;;Just a test for require.
(require 'or-startup)

;;Use package projectile for project interaction library.
(use-package projectile
  :init
  (projectile-mode 1)
  :bind (:map projectile-mode-map
	      ("C-c p" . projectile-command-map))
  :config
  ;;Choose a shell for different os.
  (setq shell-file-name "/bin/bash"))

;;In order to use rust ,we need to Install lsp-mode and rust-mode.
(use-package lsp-mode
;; :init
;;  (setq lsp-keymap-prefix "C-c l")
  :hook (
;;         (c++-mode . lsp-deferred)
;;	 (c-mode . lsp-deferred)
	 (rust-mode . lsp-deferred))
;;	 (python-mode . lsp-deferred))
  :commands lsp-deferred
  :config
  (setq rust-format-on-save t))

(use-package rust-mode)

(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))

(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                   (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay        0.5
          treemacs-directory-name-transformer      #'identity
          treemacs-display-in-side-window          t
          treemacs-eldoc-display                   'simple
          treemacs-file-event-delay                2000
          treemacs-file-extension-regex            treemacs-last-period-regex-value
          treemacs-file-follow-delay               0.2
          treemacs-file-name-transformer           #'identity
          treemacs-follow-after-init               t
          treemacs-expand-after-init               t
          treemacs-find-workspace-method           'find-for-file-or-pick-first
          treemacs-git-command-pipe                ""
          treemacs-goto-tag-strategy               'refetch-index
          treemacs-header-scroll-indicators        '(nil . "^^^^^^")
          treemacs-hide-dot-git-directory          t
          treemacs-indentation                     2
          treemacs-indentation-string              " "
          treemacs-is-never-other-window           nil
          treemacs-max-git-entries                 5000
          treemacs-missing-project-action          'ask
          treemacs-move-forward-on-expand          nil
          treemacs-no-png-images                   nil
          treemacs-no-delete-other-windows         t
          treemacs-project-follow-cleanup          nil
          treemacs-persist-file                    (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                        'left
          treemacs-read-string-input               'from-child-frame
          treemacs-recenter-distance               0.1
          treemacs-recenter-after-file-follow      nil
          treemacs-recenter-after-tag-follow       nil
          treemacs-recenter-after-project-jump     'always
          treemacs-recenter-after-project-expand   'on-distance
          treemacs-litter-directories              '("/node_modules" "/.venv" "/.cask")
          treemacs-project-follow-into-home        nil
          treemacs-show-cursor                     nil
          treemacs-show-hidden-files               nil
          treemacs-silent-filewatch                nil
          treemacs-silent-refresh                  nil
          treemacs-sorting                         'alphabetic-asc
          treemacs-select-when-already-in-treemacs 'move-back
          treemacs-space-between-root-nodes        t
          treemacs-tag-follow-cleanup              t
          treemacs-tag-follow-delay                1.5
          treemacs-text-scale                      nil
          treemacs-user-mode-line-format           nil
          treemacs-user-header-line-format         nil
          treemacs-wide-toggle-width               70
          treemacs-width                           35
          treemacs-width-increment                 1
          treemacs-width-is-initially-locked       t
          treemacs-workspace-switch-cleanup        nil)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)
    ;; (treemacs-create-theme "Default"
    ;;   :icon-directory (treemacs-join-path treemacs-dir "icons/default")
    ;;   :config
    ;;   (progn
    ;; 	(treemacs-create-icon :file "root-open.png"   :fallback ""       :extensions (root-open))
    ;; 	(treemacs-create-icon :file "root-closed.png" :fallback ""       :extensions (root-closed))
    ;; 	(treemacs-create-icon :file "emacs.png"       :fallback "🗏 "     :extensions ("el" "elc"))
    ;; 	(treemacs-create-icon :file "readme.png"      :fallback "🗏 "     :extensions ("readme.md"))
    ;; 	(treemacs-create-icon :file "src-closed.png"  :fallback "📁 "     :extensions ("src-closed"))
    ;; 	(treemacs-create-icon :file "src-open.png"    :fallback "📂 "     :extensions ("src-open"))
    ;; 	(treemacs-create-icon :icon (all-the-icons-icon-for-file "yaml") :extensions ("yml" "yaml"))))
    
    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)
    (when treemacs-python-executable
      (treemacs-git-commit-diff-mode t))

    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple)))

    (treemacs-hide-gitignored-files-mode nil))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t d"   . treemacs-select-directory)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

;; (use-package treemacs-evil
;;   :after (treemacs evil)
;;   :ensure t)

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

(use-package treemacs-icons-dired
  :hook (dired-mode . treemacs-icons-dired-enable-once)
  :ensure t)

;; (use-package treemacs-magit
;;   :after (treemacs magit)
;;   :ensure t)

(use-package treemacs-persp ;;treemacs-perspective if you use perspective.el vs. persp-mode
  :after (treemacs persp-mode) ;;or perspective vs. persp-mode
  :ensure t
  :config (treemacs-set-scope-type 'Perspectives))

(use-package treemacs-tab-bar ;;treemacs-tab-bar if you use tab-bar-mode
  :after (treemacs)
  :ensure t
  :config (treemacs-set-scope-type 'Tabs))

(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-one")
  (doom-themes-treemacs-config)
  (doom-themes-org-config))


(use-package doom-modeline
  :init (doom-modeline-mode 1))

(use-package ace-window
    :bind (("M-o" . 'ace-window)))

(use-package ag)

(use-package ctrlf
  :config
  (ctrlf-mode t))

(use-package helm-swoop
  ;; 更多关于它的配置方法: https://github.com/ShingoFukuyama/helm-swoop
  ;; 以下我的配置仅供参考
  :bind
  (("M-i" . helm-swoop)
   ("M-I" . helm-swoop-back-to-last-point)
   ("C-c M-i" . helm-multi-swoop)
   ("C-x M-i" . helm-multi-swoop-all)
   :map isearch-mode-map
   ("M-i" . helm-swoop-from-isearch)
   :map helm-swoop-map
   ("M-i" . helm-multi-swoop-all-from-helm-swoop)
   ("M-m" . helm-multi-swoop-current-mode-from-helm-swoop))
  :config
  ;; 它像 helm-ag 一样，可以直接修改搜索结果 buffer 里的内容并 apply
  (setq helm-multi-swoop-edit-save t)
  ;; 如何给它新开分割窗口
  ;; If this value is t, split window inside the current window
  (setq helm-swoop-split-with-multiple-windows t))


;;
(toggle-frame-maximized)

;;; init.el ends here
