#|
1. n = 5
if n = 5 => 2 ** (5 - 1) => 2 ** 4 = 16
a - 1
b - 2
c - 4
d - 8
e - 16
Answer: for the a - 4 bits, for e - 1 bit.

2. n = 10
if n = 10 => 2 ** (10 - 1) => 2 ** 9 = 512
alphabet:
a - 1
b - 2
c - 4
d - 8
e - 16
f - 32
g - 64
h - 128
i - 256
j - 512
Answer: for the a - 9 bits, for j - 1 bit.

So the logic is that for first element you can find count by formula 
2 ** (n - 1) and for the last it always will be 1 beat.
|#

(define sample-tree-1 (generate-huffman-tree '(
    (a 1) 
    (b 2) 
    (c 4) 
    (d 8)
    (e 16))))

(define sample-tree-2 (generate-huffman-tree '(
    (a 1) 
    (b 2) 
    (c 4) 
    (d 8)
    (e 16)
    (f 32)
    (g 64)
    (h 128)
    (i 256)
    (j 512))))

(newline) (display (encode '(a) sample-tree-1)) ; (1 1 1 1)
(newline) (display (encode '(e) sample-tree-1)) ; (0)
(newline) (display (encode '(a) sample-tree-2)) ; (1 1 1 1 1 1 1 1 1)
(newline) (display (encode '(j) sample-tree-2)) ; (0)