(define (make-queue)
  (define queue (cons '() '()))

  (define (front-ptr) (car queue))

  (define (rear-ptr) (cdr queue))

  (define (empty-queue?) (null? (front-ptr)))

  (define (set-front-ptr! item) (set-car! queue item))

  (define (set-rear-ptr! item) (set-cdr! queue item))

  (define (insert-queue! item)
    (let ((new-pair (cons item '())))
      (if (empty-queue?)
          (begin
            (set-front-ptr! new-pair)
            (set-rear-ptr! new-pair))
          (begin
            (set-cdr! (rear-ptr) new-pair)
            (set-rear-ptr! new-pair)))
      queue))

  (define (delete-queue!) 
    (if (empty-queue?)
        (error "Empty queue was provided -- DELETE-QUEUE")
        (let ((new-front (cdr (front-ptr))))
          (set-front-ptr! new-front)
          (if (null? new-front)
              (set-rear-ptr! '()))
          queue)))

  (define (dispatch operation)
    (cond ((eq? operation 'insert) insert-queue!)
          ((eq? operation 'delete) delete-queue!)
          (else (error "Incorrect operation -- MAKE-QUEUE"))))

  dispatch)

(define my-queue (make-queue))
(newline) (display ((my-queue 'insert) 7)) ; ((7) 7)
(newline) (display ((my-queue 'insert) 8)) ; ((7 8) 8)
(newline) (display ((my-queue 'insert) 9)) ; ((7 8 9) 9)
(newline) (display ((my-queue 'delete)))   ; ((8 9) 9)