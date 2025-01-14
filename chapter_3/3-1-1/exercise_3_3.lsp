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
              (else (error "Unknown operation -- DISPATCH")))
        (error "Incorrect password -- DISPATCH")))

  dispatch)

(define acc (make-account 'secret-password 100))
(newline) (display ((acc 'secret-password 'withdraw) 50))       ; 50
; (newline) (display ((acc 'secret-password '1-withdraw) 60))   ; Unknown operation -- DISPATCH
; (newline) (display ((acc 'secret-password 'withdraw) 60))     ; Not enough money -- WITHDRAW
; (newline) (display ((acc '1-secret-password 'withdraw) 60))   ; Incorrect password -- DISPATCH
(newline) (display ((acc 'secret-password 'deposit) 40))    ; 90
(newline) (display ((acc 'secret-password 'withdraw) 60))   ; 30