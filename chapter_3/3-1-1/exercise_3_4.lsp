(define (make-account password balance)
  (define password-attempts 7)

  (define (withdraw amount)
    (if (>= balance amount)
        (begin 
          (set! balance (- balance amount)) 
          balance)
        "Not enough money -- WITHDRAW"))

  (define (deposit amount)
    (begin 
      (set! balance (+ balance amount)) 
      balance))

  (define (call-the-cops) "Call the cops!!!")

  (define (dispatch input-password operation amount)
    (if (eq? input-password password)
        (cond ((eq? operation 'withdraw) (withdraw amount))
              ((eq? operation 'deposit) (deposit amount))
              (else (error "Unknown operation -- DISPATCH")))
        (begin
            (if (= password-attempts 0) 
                (call-the-cops)
                (begin 
                    (set! password-attempts (- password-attempts 1))
                    "Incorrect password -- DISPATCH")))))

  dispatch)

(define acc (make-account 'secret-password 100))
(newline) (display (acc '1-secret-password 'withdraw 50)) ; Incorrect password -- DISPATCH
(newline) (display (acc '2-secret-password 'withdraw 50)) ; Incorrect password -- DISPATCH
(newline) (display (acc '3-secret-password 'withdraw 50)) ; Incorrect password -- DISPATCH
(newline) (display (acc '4-secret-password 'withdraw 50)) ; Incorrect password -- DISPATCH
(newline) (display (acc '5-secret-password 'withdraw 50)) ; Incorrect password -- DISPATCH
(newline) (display (acc '6-secret-password 'withdraw 50)) ; Incorrect password -- DISPATCH
(newline) (display (acc '7-secret-password 'withdraw 50)) ; Incorrect password -- DISPATCH
(newline) (display (acc '8-secret-password 'withdraw 50)) ; Call the cops!!!