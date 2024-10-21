# Lisp Syntax

### comments from Lisp

```
;

#||#
```

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

kebab-case: "do-function"

```
(define (square x) 
    (* x x)
)

(define (check-carmichael-number n)
  (newline)
  (display n) 
  ;(do-fermat-test n (- n 1))
)
```

### conditionals

As much as you need.

```
(cond 
    ((condition) x) 
    ((condition) 0)
    ((condition) (- x))
)

(cond ((condition) (- x)) (else x))

(if (condition) (- x)  x)

(cond 
    ((condition) 
        (begin
            ()
            ()
            ...
        )
    )
    (else 
        (begin
            ()
            ()
            ...
        )
    )
)
```

### lambda

```
((lambda (x y z) (+ x y (square z))) 1 2 3)
```

### local variables 

```
(display 
    (let ((x 3))
        (+ x 
           (* x 10)
        )
    )
)

(let 
    ((⟨пер1⟩ ⟨выр1⟩) 
    (⟨пер2⟩ ⟨выр2⟩)
    ...
    (⟨перn⟩ ⟨вырn⟩))

⟨тело⟩
)
```

### pair

```
(define x (cons 1 2)) 

(define y (cons 3 4)) 

(define z (cons x y)) 

(car (car z)) ; 1

(car (cdr z)) ; 3
```
