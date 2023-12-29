
;;; package --- Summary:
;;;     This is a emacs configuration file with explanations(annotations) as much as possible.
;;;     So that, with the help of "C-h h\k\v\o" and this file, Emacs is going to be your favourite editor.
;;; Commentary:
;;;     All the code was packed in just only one file increasingly, which will not be scattered into files.
;;;     Beacuse, I think, a well-organized emacs.d is not friendly emough for the beginners\I.
;;;     So that, you can read or look up the code line by line, and enentually you\I will master the Emacs.
;;; Code:
;;;     Alought there are some explanations behind the code, we still suggest u to figure out why it exist.
;;;     Mostly, the reason will be found at its github README.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;Open the menu-bar, which is useful for novice(me).
;;(menu-bar-mode -1)

;;Close the tool-bar.
(tool-bar-mode -1)

;;Close the scroll-bar.
(scroll-bar-mode -1)

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

;;Enable the absolute line-numbers for all mode.
(global-display-line-numbers-mode 1)

;;Load the FEATURE 'package in package.el.
(require 'package)

;;Initialize packages.
(unless (bound-and-true-p package--initialized)
  (package-initialize))

;;Update like sudo apt undate.
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;;Load FEATURE use-package.
(require 'use-package)

;;Set the packages installed automatically if not already present.
(setq use-package-always-ensure t)

;Use package helm for searching intelligently in minibuffer.
(use-package helm
  :bind (("M-x" . helm-M-x)
	 ("C-x C-f" . helm-find-files))
  ;;Alought helm-mode is setted, we still need to config two binds before.
  :config
  (helm-mode 1))

;;Use package company for complete-anything.
(use-package company
  :hook(after-init . global-company-mode);
  :config
  (setq  company-minimum-prefix-length 2;How many characters was typed before complete.
	 company-idle-delay 0.2;Time to delay before complete.
	 company-tooltip-align-annotations t;Annotations align at right.
	 company-tooltip-limit 20;Maximum number of the candidates.
	 company-show-quick-access t));Use M-[num] to access candidates quickly.

;;Use package flycheck for syntax checking.
(use-package flycheck
  :init (global-flycheck-mode)
  :config
  ;; flycheck-load-path need to be set the same as the 'load-path.
  (setq-default flycheck-emacs-lisp-load-path 'inherit))

;;Just a test of require function.
(require 'or-startup)


;;; init.el ends here
