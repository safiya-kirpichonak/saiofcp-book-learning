#|
1. Process when normal-order evaluation (NOE):

gcd(206, 40):
    40 != 0
    gcd(40, (206 % 40)):
        6 != 0
        gcd(6, (40 % 6)):
            4 != 0
            gcd(4, (6 % 4)):
                2 != 0
                gcd(2, (4 % 2)):
                    4 % 2 == 0 => 2

2. Process when applicative-order evaluation (AOE):
gcd(206, 40):
    40 != 0
    gcd(40, 6):
        6 != 0
        gcd(6, 4):
            4 != 0
            gcd(4, 2):
                2 != 0 => 2

"Remainder" function will be called 4 times in both cases. I am not sure about it.
|#

(define (gcd a b) 
    (if (= b 0)
        a
        (gcd b (remainder a b))
    )
)

(newline)
(display (gcd 206 40))
(newline)