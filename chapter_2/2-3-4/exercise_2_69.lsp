; +-----------------------------+
; operations with leafs
; +-----------------------------+

(define (make-leaf symbol weight)
  (list 'leaf symbol weight))

(define (leaf? object)
  (eq? (car object) 'leaf))

; take symbol from leaf (second item in list)
(define (symbol-leaf x) (cadr x))

; take weight from leaf (third item in list)
(define (weight-leaf x) (caddr x))

; +-----------------------------+
; operations with trees
; +-----------------------------+

(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))

; take left brach (first element)
(define (left-branch tree) (car tree))

; take right brach (second element)
(define (right-branch tree) (cadr tree))

; take symbol from leaf or list of symbols from tree (third element)
(define (symbols tree)
  (if (leaf? tree) (list (symbol-leaf tree)) (caddr tree)))

; take weight from leaf or list of symbols from tree (fourth element)
(define (weight tree)
  (if (leaf? tree) (weight-leaf tree) (cadddr tree)))

; +-----------------------------+
; Huffman algorithm
; +-----------------------------+

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set) (adjoin-set x (cdr set))))))

; take list like ((A 4) (B 2) (C 1) (D 1)) and converts it 
; to the ((leaf d 1) (leaf c 1) (leaf b 2) (leaf a 4)) - so 
; now it leafs and sorted by weight
(define (make-leaf-set pairs)
  (if (null? pairs) '()
      (let ((pair (car pairs)))
        (adjoin-set (make-leaf (car pair) (cadr pair))
                    (make-leaf-set (cdr pairs))))))

(define (generate-huffman-tree pairs) 
    (successive-merge (make-leaf-set pairs)))


