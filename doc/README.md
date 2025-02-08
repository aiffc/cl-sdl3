To generate docstrings.lisp file run the `extract-documentation.lisp` script:

```shell
sbcl --load extract-documentation.lisp --eval "(run)" --eval "(quit)" /usr/local/include/SDL3/ docstrings.lisp
sbcl --load extract-documentation.lisp --eval "(run)" --eval "(quit)" /usr/local/include/SDL3_image/ image_docstrings.lisp
sbcl --load extract-documentation.lisp --eval "(run)" --eval "(quit)" /usr/local/include/SDL3_ttf/ ttf_docstrings.lisp

```
