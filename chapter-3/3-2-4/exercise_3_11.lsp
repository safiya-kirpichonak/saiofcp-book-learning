#|
1. State of acc is in the E1, state of acc2 is in the E2.
2. They don't conflict because they are in different frames (E1 and E2).
3. They have the same stricture because they created from the sam function (make-account).
+-------------------------------------------------------+
global env:
make-account
acc
acc2
+-------------------------------------------------------+
|make-account                   |                   |
|                               |                   |
params: balance                 +--------------+    +--------------+
body:                           E1 env:             E2 env:
(define (withdraw amount)...)   balance = 50        balance = 100
(define (deposit amount)...)    functions there     functions there
(define (dispatch m)...)        +--------------+    +--------------+
                                |                   |
                                +--------------+    +--------------+
                                E1.n there (when    E2.n there (when
                                call functions      call functions 
                                for this acc)       for this acc)
                                +--------------+    +--------------+
|#

(define (make-account balance) 

    (define (withdraw amount) 
        (if (>= balance amount)
            (begin 
                (set! balance (- balance amount)) 
                balance)
            "Not enough money -- WITHDRAW")) 

    (define (deposit amount)
        (set! balance (+ balance amount)) balance)

    (define (dispatch m)
        (cond ((eq? m 'withdraw) withdraw)
              ((eq? m 'deposit) deposit)
              (else (error "Unknown call -- MAKE-ACCOUNT" m))))

    dispatch)

(define acc (make-account 50))
(newline) (display ((acc 'deposit) 40)) ; 90
(newline) (display ((acc 'deposit) 60)) ; 30
(define acc2 (make-account 100))
(newline) (display ((acc2 'deposit) 40)) ; 140
(newline) (display ((acc2 'deposit) 60)) ; 200