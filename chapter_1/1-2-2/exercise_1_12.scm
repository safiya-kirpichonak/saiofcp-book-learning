(define (factorial result count)
  (cond
    ((= count 0) 1)
    ((= count 1) result)
    (else (factorial (* result count) (- count 1)))
  )
)

(define (pascal-formula rowNumber itemNumber)
  (/ (factorial 1 rowNumber)
     (*
        (factorial 1 itemNumber) 
        (factorial 1 (- rowNumber itemNumber))
     )
  )
)

(define (pascal count)
  (pascal-iteration 0 0 count)
)

(define (pascal-iteration row item count)
  (when (<= row count)
    (display (string-append (number->string row) ":" (number->string item) " = "))
    (display (pascal-formula row item))
    (newline)
    (if (= item row)
        (pascal-iteration (+ row 1) 0 count)
        (pascal-iteration row (+ item 1) count)
    )
  )
)

(pascal 3)