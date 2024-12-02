#lang sicp

(#%require sicp-pict)

(define (right-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (right-split painter (- n 1))))
        (beside painter (below smaller smaller)))))

(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split painter (- n 1))))
        (beside painter (below smaller smaller)))))

(define (corner-split painter n)
  (if (= n 0)
      painter
      (let* ((up (up-split painter (- n 1)))
             (right (right-split painter (- n 1)))
             (corner (corner-split painter (- n 1))))
        (beside (below painter up)
                (below right corner)))))

(paint (corner-split einstein 3))