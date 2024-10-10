# Lisp Syntax

### combination like (operator operands...)

```
(+ 137 349)

(* 25 4 12)

(display (+ 1 2))
```

### variables

```
(define pi 3.14159)

(define radius 10)

(* pi (* radius radius))
```

### procedure definitions

```
(define (square x) (* x x))
```

### conditionals

As much as you need.

```
(cond 
    ((> x 0) x) 
    ((= x 0) 0)
    ((< x 0) (- x)))

(cond 
    ((< x 0) (- x))
    (else x))

(if (< x 0) 
    (- x) 
    x)
```

