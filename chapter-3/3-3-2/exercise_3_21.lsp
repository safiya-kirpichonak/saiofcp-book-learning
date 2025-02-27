(define (front-ptr queue) (car queue))

(define (rear-ptr queue) (cdr queue))

(define (set-front-ptr! queue item) (set-car! queue item))

(define (set-rear-ptr! queue item) (set-cdr! queue item))

(define (empty-queue? queue) (null? (front-ptr queue)))

(define (make-queue) (cons '() '()))

(define (front-queue queue) 
		(if (empty-queue? queue)
				(error "Empty queue was provided -- FRONT-QUEUE" queue) 
				(car (front-ptr queue))))

(define (insert-queue! queue item) 
    (let ((new-pair (cons item '())))
         (cond ((empty-queue? queue) 
                    (set-front-ptr! queue new-pair) 
                    (set-rear-ptr! queue new-pair) queue)
                (else
                    (set-cdr! (rear-ptr queue) new-pair) 
                    (set-rear-ptr! queue new-pair) 
                    queue))))

(define (delete-queue! queue) 
		(cond ((empty-queue? queue) (error "Empty queue was provided -- DELETE-QUEUE" queue)) 
           (else (set-front-ptr! queue (cdr (front-ptr queue))) queue)))

(define q1 (make-queue))

#|
The result like that, because the last item, after list, is 
link to the last item of the queue.
|#

(define (print-queue queue)
  (newline) (display (car queue)))

(insert-queue! q1 'a)
(print-queue q1) ; (a)

(insert-queue! q1 'b)
(print-queue q1) ; (a b)

(delete-queue! q1)
(print-queue q1) ; (b)

(delete-queue! q1)
(print-queue q1) ; ()