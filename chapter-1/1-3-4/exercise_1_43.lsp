; const compose = (f, g) => (x) => f(g(x));
; const repeated = (f, n) => (n === 1 ? f : compose(f, repeated(f, n - 1)));
; const square = (x) => x * x;
; const multiSquare = repeated(square, 2);
; console.log(multiSquare(5)); // 625

(define (compose f g)
    (lambda (x) (f (g x))))

(define (repeated f n)
    (if (= n 1)
        f
        (compose f (repeated f (- n 1)))))

(newline)
(display ((repeated square 2) 5)) ; 625
