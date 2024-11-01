# Lisp Syntax

### comments

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

- basic usage:

```
(define x (cons 1 2)) 

(define y (cons 3 4)) 

(define z (cons x y)) 

(newline)
(display (car (car z))) ; 1
(newline)
(display (cdr (cdr z))) ; 4
```

other operations:

```
(newline) (display (pair? (cons 1 2))) ; #t
```

### error

```
(error "This is an error message")
```

### list

how it works:

```
(list ⟨a1⟩ ⟨a2⟩ ... ⟨an⟩)
=
(cons ⟨a1⟩ (cons⟨a2⟩ (cons ... (cons ⟨an⟩ nil) ... ))) ; nil = nothing, empty list

(define one-through-four (list 1 2 3 4)) 

one-through-four ; (1 2 3 4)

(car one-through-four) ; 1

(cdr one-through-four) ; (2 3 4)

(car (cdr one-through-four)) ; 2

(cons 10 one-through-four) ; (10 1 2 3 4)
```

operations:

- element by index:
```
(define squares (list 1 4 9 16 25)) 

(newline)
(display (list-ref squares 3))
```

- is list empty

```
(null? items) ;true or false
```

- find length on list

```
(length squares)
```

- append 

```
(append squares odds)
(1 4 9 16 25 1 3 5 7)
```

- map 

```
(define map-result (map (lambda (x) (* x x)) (list 1 2 3 4)))

(newline) (display map-result) ; (1 4 9 16)
```

- !!! weird rules for pair + list working, if second parameter is list, it 
will be the list in result:

```
(define x (cons 5 6)) 
(define z (cons 5 (list 6 7)))
(define a (cons (list 8 9) 10)) 
(define y (cons (list 1 2) (list 3 4))) 

(newline) (display x) ; (5 . 6)
(newline) (display y) ; ((1 2) 3 4)
(newline) (display z) ; (5 6 7)
(newline) (display a) ; ((8 9) . 10)
```

