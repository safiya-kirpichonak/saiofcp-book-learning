(newline) (display (list 'a 'b 'c)) ; (a b c)

(newline) (display (list (list 'george))) ; ((george))

(newline) (display (cdr '((x1 x2) (y1 y2)))) ; ((y1 y2))

(newline) (display (cadr '((x1 x2) (y1 y2)))) ; (y1 y2)

(newline) (display (pair? (car '(a short list)))) ; #f

(define (memq item x)
  (cond ((null? x) false)
        ((eq? item (car x)) x)
        (else (memq item (cdr x)))))

(newline) (display (memq 'red '((red shoes) (blue socks)))) ; #f

(newline) (display (memq 'red '(shoes red blue socks))) ; (red blue socks)