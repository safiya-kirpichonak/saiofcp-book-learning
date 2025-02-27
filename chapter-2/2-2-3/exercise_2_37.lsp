(define (accumulate op initial sequence)
    (if (null? sequence) initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))))

(define (accumulate-n op init sequence)
    (if (null? (car sequence)) (list)
        (cons (accumulate op init (map (lambda (s) (car s)) sequence))
              (accumulate-n op init (map (lambda (s) (cdr s)) sequence)))))

(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(define (matrix-multiply-vector matrix vector)
  (map (lambda (row) 
         (let ((result (accumulate
                        (lambda (x y) 
                          (cons 
                            (+ (car y) 1) 
                            (+ 
                                (cdr y) 
                                (* 
                                    (list-ref vector (car y)) 
                                    (list-ref row (car y))))))
                        (cons 0 0) 
                        row)))
           (cdr result)))
       matrix))

(define (transpose matrix) 
     (accumulate-n cons (list) matrix))

(define (matrix-multiply-matrix matrix1 matrix2) 
  (let ((cols (transpose matrix2)))
    (map (lambda (row)
           (map (lambda (col)
                  (accumulate + 0 (map * row col)))
                cols))
         matrix1)))

(define vector1 (list 1 2 3))
(define vector2 (list 4 5 6))
(define matrix1 (list (list 1 2 3) (list 4 5 6) (list 6 7 8)))
(define matrix2 (list (list 1 4 6) (list 2 5 7) (list 3 6 8)))

(newline) (display (dot-product vector1 vector2)) ; 42
(newline) (display (matrix-multiply-vector matrix1 vector1)) ; (14, 32, 44)
(newline) (display (transpose matrix1)) ; ((1 4 6) (2 5 7) (3 6 8))
(newline) (display (matrix-multiply-matrix matrix1 matrix2)) ; ((14 32 44) (32 77 107) (44 107 149))
