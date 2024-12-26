#|
1. The count of result bits: 84;
2. The min value if fixed length: 3 bit for every symbol (log 2 8 => 3), so 36 * 3 = 108.
|#

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

; take weight from leaf or weight from tree (fourth element)
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
; operations with encoding
; +-----------------------------+

(define (symbol-in-alphabet? symbol alphabet)
  (cond ((null? alphabet) false)
        ((equal? symbol (car alphabet)) true)
        (else (symbol-in-alphabet? symbol (cdr alphabet)))))

(define (encode message tree)
  (if (null? message) '()
      (append (encode-symbol (car message) tree) 
              (encode (cdr message) tree))))

(define (encode-symbol symbol tree)
  (if (not (symbol-in-alphabet? symbol (symbols tree)))
      (error "incorrect symbol for encoding -- ENCODE-SYMBOL")
      (letrec ((iter 
                (lambda (tree)
                  (if (leaf? tree)
                      '()
                      (cons (find-bit symbol tree)
                            (iter (find-branch symbol tree)))))))
        (iter tree))))

(define (find-bit symbol tree)
    (if (symbol-in-alphabet? 
            symbol 
            (symbols (left-branch tree))) 0 1))

(define (find-branch symbol tree)
    (if (symbol-in-alphabet? 
            symbol 
            (symbols (left-branch tree))) 
                (left-branch tree) 
                (right-branch tree)))

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

(define (successive-merge temp-list)
    (cond
      ((null? temp-list) (error "should be at lest 2 leafs -- SUCCESSIVE-MERGE"))
      ((and (= (length temp-list) 1) (leaf? (car temp-list))) (error "should be at lest 2 leafs -- SUCCESSIVE-MERGE"))
      ((= (length temp-list) 1) (car temp-list))
      (else (successive-merge (create-temp-tree temp-list)))))

(define (create-temp-tree temp-list) 
    (insert-in-temp-tree 
            (make-code-tree 
                (car (cdr temp-list))
                (car temp-list) ) 
            (cddr temp-list)))

(define (insert-in-temp-tree element temp-list)
  (cond
      ((null? temp-list) (list element))
      ((<= (weight element) (weight (car temp-list))) (cons element temp-list))
      (else (cons (car temp-list) (insert-in-temp-tree element (cdr temp-list))))))

; +-----------------------------+
; example
; +-----------------------------+

(define sample-tree (generate-huffman-tree '(
    (A 2) 
    (BOOM 1) 
    (GET 2) 
    (JOB 2)
    (NA 16)
    (SHA 3)
    (YIP 9)
    (WAH 1))))

; (0 0 0 0 1 0 0 0 0 0 0 0 1 0)
; (0 0 0 1 1 1 1 1 1 1 1 1)
; (0 0 0 0 1 0 0 0 0 0 0 0 1 0)
; (0 0 0 1 1 1 1 1 1 1 1 1)
; (0 0 1 1 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1)
; (0 0 0 1 0 0 1 1 0)
(newline) (display (encode '(Get a job) sample-tree))
(newline) (display (encode '(Sha na na na na na na na na) sample-tree))
(newline) (display (encode '(Get a job) sample-tree))
(newline) (display (encode '(Sha na na na na na na na na) sample-tree))
(newline) (display (encode '(Wah yip yip yip yip yip yip yip yip yip) sample-tree))
(newline) (display (encode '(Sha boom) sample-tree))