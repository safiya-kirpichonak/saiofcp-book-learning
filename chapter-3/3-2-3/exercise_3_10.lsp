#|
+--------------------------------------------------------------+
global env:

make-withdraw-1
make-withdraw-2
W1
W2
+-------------------------------------------------------------+
|                             |   |                          |
|                             |   |                          |
|                             |   |                          |
W1 code - W1 link to env      |   W2 code - W2 link to env   |
          |                   |             |                |
          +-------------------+   +--------------------------+
          E1:                     E2:
          initial-amount = 100    initial-amount = 100
          let with balance        lambda with balance
          +-------------------+   +--------------------------+
          |                       |
          +-------------------+   +--------------------------+
          E3:                     E4:
          lambda with amount      lambda with amount
          +-------------------+   +--------------------------+
|#

(define (make-withdraw-1 initial-amount) 
    (let ((balance initial-amount))
         (lambda (amount)
            (if (>= balance amount)
                (begin 
                    (set! balance (- balance amount)) 
                    balance)
                (error "Not enough money -- MAKE-WITHDRAW")))))

(define (make-withdraw-2 initial-amount) 
    ((lambda (balance)
        (lambda (amount)
            (if (>= balance amount)
                (begin 
                    (set! balance (- balance amount)) 
                    balance)
                (error "Not enough money -- MAKE-WITHDRAW"))))
    initial-amount))

(define W1 (make-withdraw-1 100))
(newline) (display (W1 50)) ; 50

(define W2 (make-withdraw-2 100))
(newline) (display (W2 50)) ; 50