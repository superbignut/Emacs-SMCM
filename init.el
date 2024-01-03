;; -*- lexical-binding:

(add-to-list 'load-path
	     (expand-file-name (concat user-emacs-directory "lisp")))

(tool-bar-mode -1)

(scroll-bar-mode -1)

(show-paren-mode t)

(global-display-line-numbers-mode 1)

(put 'narrow-to-region 'disabled nil)

(defun open-init-file()
  "Use <f2>, open init.el."
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(global-set-key (kbd "<f2>") 'open-init-file)

(global-set-key (kbd "M-[") 'previous-buffer)

(global-set-key (kbd "M-]") 'next-buffer)

(setq-default cursor-type 'bar)

(setq inhibit-startup-screen -1)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(setq package-archives '(
			 ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
			 ("gnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
			 ("org" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")))

(require 'package)

(unless (bound-and-true-p package--initialized)
  (package-initialize))


(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


(package-install 'marginalia)
(marginalia-mode 1)

(setq use-package-always-ensure t)

(use-package paredit
  :hook
  (emacs-lisp-mode . paredit-mode)
  (lisp-interaction-mode . paredit-mode))

(use-package rainbow-delimiters
  :hook
  (emacs-lisp-mode . rainbow-delimiters-mode)
  (lisp-interaction-mode . rainbow-delimiters-mode))

(use-package helm
  :bind (("M-x" . helm-M-x)
	 ("C-x C-f" . helm-find-files))
  :init
  (helm-mode 1))

(use-package company
  :hook(after-init . global-company-mode);
  :config
  (setq  company-minimum-prefix-length 1;How many characters was typed before complete.
	 company-idle-delay 0.1;Time to delay before complete.
	 company-tooltip-align-annotations t;Annotations align at right.
	 company-tooltip-limit 20;Maximum number of the candidates.
	 company-show-quick-access t));Use M-[num] to access candidates quickly.

;; (use-package flycheck
;;   :init (global-flycheck-mode)
;;   :config
;;   (setq-default flycheck-emacs-lisp-load-path 'inherit))

(require 'or-startup)

(use-package projectile
  :init
  (projectile-mode 1)
  :bind (:map projectile-mode-map
	      ("C-c p" . projectile-command-map))
  :config
  (setq shell-file-name "/bin/bash"))

(use-package lsp-mode
  :hook (
	 (rust-mode . lsp-deferred))
  :commands lsp-deferred
  :config
  (setq rust-format-on-save t))

(use-package rust-mode)

(use-package all-the-icons
  :if (display-graphic-p))

(use-package treemacs
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
  (setq doom-themes-treemacs-theme "doom-colors")
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
  (setq helm-multi-swoop-edit-save t)
  (setq helm-swoop-split-with-multiple-windows t))


;; (package-install 'rainbow-delimiters)
;; (rainbow-delimiters-mode)
;; (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
;;
(toggle-frame-maximized)

;;; init.el ends here
