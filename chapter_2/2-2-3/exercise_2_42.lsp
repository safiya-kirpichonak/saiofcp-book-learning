; general functions

(define (accumulate operation initial sequence)
    (if (null? sequence) initial
        (operation (car sequence) (accumulate operation initial (cdr sequence)))))

(define (flatmap procedure sequence)
    (accumulate append (list) (map procedure sequence)))

(define (enumerate-interval low high) 
    (if (> low high) (list)
        (cons low (enumerate-interval (+ low 1) high))))

; subject area functions

(define (empty-board) (list))

(define (adjoin-position row column rest-of-queens)
  (append rest-of-queens (list (list column row))))

(define (safe? column-index all-positions)
  (let* ((queen (list-ref all-positions (- column-index 1)))
         (unsafe-positions (filter (lambda (item) (not (equal? item queen))) all-positions)))

    (define (iter positions)
      (cond ((null? positions) #t)
            (else
             (let ((another-queen (car positions)))
               (cond ((= (car (cdr another-queen)) (car (cdr queen))) #f)
                     ((= (abs (- (car (cdr another-queen)) (car (cdr queen))))
                         (abs (- (car another-queen) (car queen)))) #f)
                     (else (iter (cdr positions))))))))

    (iter unsafe-positions)))

(define (queens board-size)
  (define (queen-columns n)
    (if (= n 0) (list (empty-board))
        (filter
         (lambda (positions) (safe? n positions))
         (flatmap
            (lambda (rest-of-queens)
                (map (lambda (new-row) (adjoin-position new-row n rest-of-queens))
                     (enumerate-interval 1 board-size)))
            (queen-columns (- n 1))))))
  (queen-columns board-size))

#|
Solution 1: ((1 2) (2 4) (3 1) (4 3))

. Q . .
. . . Q
Q . . .
. . Q .

Solution 2: ((1 3) (2 1) (3 4) (4 2))

. . Q .
Q . . .
. . . Q
. Q . .
|#

(newline) (display (queens 4)) ; (((1 2) (2 4) (3 1) (4 3)) ((1 3) (2 1) (3 4) (4 2)))
