(define (make-account password balance)

  (define (withdraw amount)
    (if (>= balance amount)
        (begin 
          (set! balance (- balance amount)) 
          balance)
        (error "Not enough money -- WITHDRAW")))

  (define (deposit amount)
    (begin 
      (set! balance (+ balance amount)) 
      balance))

  (define (dispatch input-password operation)
    (if (eq? input-password password)
        (cond ((eq? operation 'withdraw) withdraw)
              ((eq? operation 'deposit) deposit)
              ((eq? operation 'check-password) #t)
              (else (error "Unknown operation -- DISPATCH")))
        #f))

  dispatch)

(define (make-joint account password new-password)
    (if (account password 'check-password) 
        (lambda (input-password operation)
            (if (eq? input-password new-password)
                (account password operation)
                (error "Incorrect account password -- MAKE-JOIN"))) 
        (error "Incorrect account password -- MAKE-JOIN")))

(define peter-account (make-account 'secret-password 100))
(newline) (display ((peter-account 'secret-password 'withdraw) 50))   ; 50

(define paul-account (make-joint peter-account 'secret-password 'secret-password-2))
(newline) (display ((paul-account 'secret-password-2 'withdraw) 50))   ; 0