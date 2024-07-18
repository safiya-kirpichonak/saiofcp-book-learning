;;; this function take necessary operator: if b < 0, it takes - and + otherwise.

(define (a_plus_asb-b a b)
    ((if (> b 0) + -) a b)
)