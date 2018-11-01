;;; packages.el --- rscope layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: Lau <lau@lau-zenbook>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `rscope-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `rscope/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `rscope/pre-init-PACKAGE' and/or
;;   `rscope/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst rscope-packages
  '(rscope :location (recipe :fetcher github :repo "rjarzmik/rscope")
           )
  )

(defun rscope/init-rscope()
  (use-package rscope)
  )
;;; packages.el ends here
