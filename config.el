(defun random-file-in-directory (directory)
  "Return the path of a random file in DIRECTORY."
  (let* ((files (directory-files directory t "^[^.]" t)) ; Get list of files excluding "." and ".."
         (file-count (length files)))
    (when (> file-count 0) ; Check if there are any files in the directory
      (nth (random file-count) files)))) ; Return a random file from the list
;; (setq doom-theme 'catppuccin)
;; (add-hook 'server-after-make-frame-hook #'catppuccin-reload)
(setq doom-theme 'doom-tokyo-night)
 (add-to-list 'default-frame-alist '(alpha . 90))
(setq display-line-numbers-type 'relative)
(setq dirvish-attributes
      '(vc-state subtree-state git-msg file-time file-size))
(setq scroll-margin 8)
(setq evil-normal-state-cursor '(box "white"))
(setq evil-insert-state-cursor '(box "white"))
(setq evil-visual-state-cursor '(box "white"))
(beacon-mode 1)
(nyan-mode)
(xterm-mouse-mode 1)
(setq fancy-splash-image (random-file-in-directory "~/assets/emacs_stuff"))
(setq doom-font (font-spec :family "Iosevka" :size 15))
(zoom-mode t)

(map! :map cdlatex-mode-map
      :i "TAB" #'cdlatex-tab)
(add-hook 'latex-mode-hook #'xenops-mode)
(add-hook 'LaTeX-mode-hook #'xenops-mode)
(setq +latex-viewers '(pdf-tools zathura))
(setq auto-revert-interval 0.5)
(add-hook! 'latex-mode-hook
  (setq Tex-engine 'xelatex) 99)
(setq TeX-auto-save t
      TeX-parse-self t)
(setq-default TeX-master nil)

(setq shell-file-name "/usr/bin/zsh"
      vterm-max-scrollback 5000)
(setq eshell-rc-script "~/.config/doom/eshell/profile"
      eshell-aliases-file "~/.config/doom/eshell/aliases"
      eshell-history-size 5000
      eshell-buffer-maximum-lines 5000
      eshell-hist-ignoredups t
      eshell-scroll-to-bottom-on-input t
      eshell-destroy-buffer-when-process-dies t
      eshell-visual-commands'("bash" "fish" "htop" "ssh" "top" "zsh"))
(map! :leader
      :desc "Eshell" "v s" #'eshell
      :desc "Eshell popup" "v y" #'+eshell/toggle
      :desc "Counsel eshell history" "v h" #'counsel-esh-history
      :desc "Vtern popup" "v t" #'+vterm/toggle)

(setq org-directory "~/org/")
(after! org
  (use-package! toc-org
    :hook (org-mode . toc-org-mode)
    :config
    (setq toc-org-hrefify-default "org")
    (add-hook 'org-mode-hook #'toc-org-enable))
(use-package! org-auto-tangle
  :defer t
  :hook (org-mode . org-auto-tangle-mode)
  :config
  (setq org-auto-tangle-default t)))
(defun dt/insert-auto-tangle-tag ()
  "Insert auto-tangle tag in a literate config."
  (interactive)
  (evil-org-open-below 1)
  (insert "#+auto_tangle: t ")
  (evil-force-normal-state))
(map! :leader
      :desc "Insert auto_tangle tag" "i a" #'dt/insert-auto-tangle-tag)

(map! :leader "." nil)
(map! :leader
      :desc "Better Find File"
      "." #'zoxide-find-file)
(map! :leader
      :desc "Open files buffer"
      "e" #'dired)
(map! :leader
      :desc "Ripgrep a directory"
      "r g" #'deadgrep)

(setq user-full-name "Patrick Lee"
      user-mail-address "leepatrick338@gmail.com")

(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)
(auto-save-visited-mode 1)

(after! projectile
  (setq projectile-project-root-files-bottom-up (remove ".git"
    projectile-project-root-files-bottom-up)
        ))
(setq projectile-project-search-path '("~/.config/doom" "~/dotfiles" "~/work/phptest"))
(setq projectile-ignored-projects '("~"))
(setq projectile-known-projects '("~/dotfiles"
                                   "~/.config/doom"
                                   ))

(after! undo-tree
  (setq undo-tree-auto-save-history nil))

(add-hook! 'python-mode-hook (modify-syntax-entry ?_ "w"))
(setq lsp-pyright-langserver-command "basedpyright")
(pyvenv-mode t)
(setq pyvenv-post-activate-hooks
      (list (lambda ()
              (setq python-shell-interpreter (concat pyvenv-virtual-env "bin/python3")))))
(setq pyvenv-post-deactivate-hooks
      (list (lambda ()
              (setq python-shell-interpreter "python3"))))
