;; -*- lexical-binding: t; -*-

(TeX-add-style-hook
 "preamble"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("juliamono" "Scale=MatchUppercase") ("indentfirst" "") ("float" "") ("plex-otf" "RM={Scale=0.94}" "SS={Scale=0.94}" "SScon={Scale=0.94}" "TT={Scale=MatchLowercase,FakeStretch=0.9}" "DefaultFeatures={Ligatures=Common}") ("libertine" "")))
   (TeX-run-style-hooks
    "indentfirst"
    "float"
    "plex-otf"
    "libertine"))
 :latex)

