(define (make-table)
    (let ((local-table (list '*table*)))

    (define (show) (newline) (display local-table))

    (define (lookup key-1 key-2 same-key?)
        (let ((subtable (same-key? key-1 (cdr local-table))))
            (if subtable
                    (let ((record (same-key? key-2 (cdr subtable))))
                        (if record (cdr record) false))
        false)))

    (define (insert! key-1 key-2 value same-key?)
        (let ((subtable (same-key? key-1 (cdr local-table))))
            (if subtable
                (let ((record (same-key? key-2 (cdr subtable))))
                    (if record
                            (set-cdr! record value) 
                            (set-cdr! subtable (cons (cons key-2 value) (cdr subtable)))))
                (set-cdr! local-table (cons (list key-1 (cons key-2 value)) (cdr local-table)))))
    'ok)

    (define (dispatch m)
        (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            ((eq? m 'show-proc!) show)
            (else (error "Unknown operation -- TABLE" m))))

dispatch))

(define operation-table (make-table)) 
(define get (operation-table 'lookup-proc)) 
(define put (operation-table 'insert-proc!))
(define show (operation-table 'show-proc!))

; now you can put any function to check keys
(put 'math '+ 43 assoc)
(put 'math '- 45 assoc)
(put 'math '* 42 assoc)
(put 'letters 'a 97 assoc)
(put 'letters 'b 98 assoc)

; (*table* 
;       (letters (b . 98) (a . 97)) 
;       (math (* . 42) (- . 45) (+ . 43)))
(show)