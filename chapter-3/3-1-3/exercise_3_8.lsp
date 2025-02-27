(define state -1)

(define (f input-number)
  (if (= state -1)
      (begin
        (set! state input-number)
        input-number)
      0))

; It is funny, I thought the answer will be 0, but here 
; the arguments are from right to left, not left to right
; so you need to replace arguments to get 0

; (newline) (display (+ (f 0) (f 2))) ; 2
(newline) (display (+ (f 2) (f 0))) ; 0