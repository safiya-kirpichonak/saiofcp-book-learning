#lang sicp

(#%require sicp-pict)

(define (split ft st)
  (define (f painter n)
    (if (= n 0)
      painter
      (let ((smaller (f painter (- n 1))))
        (ft painter (st smaller smaller)))))
    f)

(define right-split (split beside below))
(define up-split (split below beside))

(paint (right-split einstein 2))
(paint (up-split einstein 2))