;;; emacs-xo.el --- XO linter integration

;; Copyright (C) 2021 Pablo Fonseca

;; Author: Pablo Fonseca <pablofonseca777@gmail.com>
;; Keywords: lint, js-lint
;; Version: 1.0

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; TODO

;;; Code:

(require 'compile)

(defun emacs-xo/compile-on-save-start ()
  (setq compile-command (concat "xo --fix " (buffer-file-name)))
  (let ((buffer (compilation-find-buffer)))
    (unless (get-buffer-process buffer)
      (recompile))))

(define-minor-mode emacs-xo/compile-on-save-mode
  "Minor mode to automatically call `xo --fix' whenever the
  current buffer is saved. When there is ongoing compilation,
  nothing happens."
  :lighter " CoS"
  (if emacs-xo/compile-on-save-mode
      (progn  (make-local-variable 'after-save-hook)
              (add-hook 'after-save-hook 'emacs-xo/compile-on-save-start nil t))
    (kill-local-variable 'after-save-hook)))

(provide 'emacs-xo')
