(define (count-pairs x) 
    (if (not (pair? x))
        0
        (+ (count-pairs (car x)) 
           (count-pairs (cdr x)) 
           1)))

#|
* ------ *
|        |
1        * --- 3
         |
         2
|#
(newline) (display (count-pairs '(cons 1 
                                      (cons 2 3)))) ; 6

#|
* ------ *
|        |
*        *
| \      | \
1  2     3  4
|#
(newline) (display (count-pairs '(cons 
                                    (cons 1 2) 
                                    (cons 3 4)))) ; 9

#|
* -------- *
|          |
*          *
| \        | \
*  3       4  *
| \           | \
1  2          5  6
|#
(newline) (display (count-pairs '(cons (cons 
                                            (cons 1 2) 
                                            3) 
                                       (cons 
                                            4 
                                            (cons 5 6))))) ; 15

(define x 
            (let ((y (cons 'a 'b))) 
                 (set-cdr! y y) y)) ; infinite cdr
; (newline) (display (count-pairs x)) ;Aborting!: maximum recursion depth exceeded