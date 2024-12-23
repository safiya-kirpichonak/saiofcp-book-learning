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
; operations with decoding
; +-----------------------------+

(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits) '()
        ; take next branch by first bit from bits list
        (let ((next-branch (choose-branch (car bits) current-branch)))
         (if (leaf? next-branch)
              ; if current element is leaf, do current symbol + next symbols from result
              (cons (symbol-leaf next-branch) (decode-1 (cdr bits) tree))
              ; if current element is tree, just ignore it and move deeper with the next branch
              (decode-1 (cdr bits) next-branch)))))
  (decode-1 bits tree))

(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch branch))
        ((= bit 1) (right-branch branch))
        (else (error "unsupported bit -- CHOOSE-BRANCH" bit))))

; +-----------------------------+
; example
; +-----------------------------+

(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree
                   (make-leaf 'B 2)
                   (make-code-tree (make-leaf 'D 1)
                                  (make-leaf 'C 1)))))

(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))

(newline) (display (decode sample-message sample-tree)) ; (a d a b b c a)