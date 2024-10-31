#|
The fact is that computers have certain issues when working with 
floating-point numbers due to the specifics of the binary system. 
Here’s a simple example demonstrating this problem:

(newline) (display (+ 0.1 0.2)) ; 0.30000000000000004

Thus, when it comes to intervals with small error margins, many similar distortions 
arise in calculations. Therefore, the fewer operations on floating-point numbers, the better. 
For this reason, `pair2` will perform better because intervals with small errors are used only 
once in it, unlike in `pair1`, where there are many such operations, resulting in more 
inaccuracies in the operation results.
|#

(define (par1 r1 r2)
    (div-interval (mul-interval r1 r2) 
                  (add-interval r1 r2)))

(define (par2 r1 r2)
        (let ((one (make-interval 1 1)))
            (div-interval one
                (add-interval (div-interval one r1)
                              (div-interval one r2)))))