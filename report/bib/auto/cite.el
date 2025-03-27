;; -*- lexical-binding: t; -*-

(TeX-add-style-hook
 "cite"
 (lambda ()
   (LaTeX-add-bibitems
    "tanenbaum_book_modern-os_ru"
    "robbins_book_bash_en"
    "zarrelli_book_mastering-bash_en"
    "newham_book_learning-bash_en"))
 '(or :bibtex :latex))

