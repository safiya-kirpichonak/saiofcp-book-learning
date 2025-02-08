; 1 - front-deque; 2 - end-deque; 3 - deque
(define (make-deque) (list '() '() '()))

(define (empty-deque? deque)
  (and
   (null? (front-deque deque))
   (null? (end-deque deque))))

(define (front-deque deque) (car deque))

(define (end-deque deque) (car (cdr deque)))

(define (actual-deque deque) (car (cdr (cdr deque))))

(define (end-insert-deque! deque item) 
    (cond ((empty-deque? deque)
           (set-car! deque (list item))
           (set-car! (cdr deque) (list item))
           (set-car! (cdr (cdr deque)) (list item))
           deque)
          (else
           (set-car! (cdr deque) (list item))
           (set-car! (cdr (cdr deque)) (append (actual-deque deque) (list item)))
           deque)))

(define (end-delete-deque! deque)
  (cond ((empty-deque? deque) (error "Empty queue was provided -- END-DELETE-DEQUE!"))
        (else
         (let ((deque-list (actual-deque deque)))
              (if (= (length deque-list) 1)
               (begin
                 (set-car! deque '())
                 (set-car! (cdr deque) '())
                 (set-car! (cdr (cdr deque)) '()))
               (begin
                 (set-car! (cdr (cdr deque)) (reverse (cdr (reverse deque-list))))
                 (set-car! (cdr deque) (list (last (reverse (cdr (reverse deque-list))))))))
           deque))))

(define (front-insert-deque! deque item)
  (cond ((empty-deque? deque)
         (set-car! deque (list item))
         (set-car! (cdr deque) (list item))
         (set-car! (cdr (cdr deque)) (list item))
         deque)
        (else
         (set-car! deque (list item))
         (set-car! (cdr (cdr deque)) (cons item (actual-deque deque)))
         deque)))

(define (front-delete-deque! deque)
  (cond ((empty-deque? deque) (error "Empty queue was provided -- FRONT-DELETE-DEQUE!"))
        (else
         (let ((new-deque (cdr (actual-deque deque))))
           (set-car! deque (if (null? new-deque) '() (list (car new-deque))))
           (set-car! (cdr (cdr deque)) new-deque)
           (if (null? new-deque) (set-car! (cdr deque) '()))
           deque))))

#|
+--------------+
testing
+--------------+
|#
(define my-deque (make-deque))
(newline) (display (front-deque my-deque))
(newline) (display (end-deque my-deque))
(newline) (display (actual-deque my-deque))
(newline) (display (empty-deque? my-deque))

(end-insert-deque! my-deque 1)
(newline) (display my-deque) ; ((1) (1) (1))
(end-insert-deque! my-deque 2)
(newline) (display my-deque) ; ((1) (2) (1 2))
(end-insert-deque! my-deque 3)
(newline) (display my-deque) ; ((1) (3) (1 2 3))
(end-delete-deque! my-deque)
(newline) (display my-deque) ; ((1) (2) (1 2))
(end-delete-deque! my-deque)
(newline) (display my-deque) ; ((1) (1) (1))
(end-delete-deque! my-deque)
(newline) (display my-deque) ; (() () ())

(front-insert-deque! my-deque 1)
(newline) (display my-deque) ; ((1) (1) (1))
(front-insert-deque! my-deque 2)
(newline) (display my-deque) ; ((2) (1) (2 1))
(front-insert-deque! my-deque 3)
(newline) (display my-deque) ; ((3) (1) (3 2 1))
(front-delete-deque! my-deque)
(newline) (display my-deque) ; ((2) (1) (2 1))
(front-delete-deque! my-deque)
(newline) (display my-deque) ; ((1) (1) (1))
(front-delete-deque! my-deque)
(newline) (display my-deque) ; (() () ())