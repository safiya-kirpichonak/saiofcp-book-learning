#|
In Lisp, quotation marks do not work the same way as in other programming languages. They do not 
indicate the start of a string but are used to prevent evaluation of data. For example, when we 
write '(a b c), it will be a list (a b c), not a string containing the characters "a", "b", and "c".

The first quotation mark turns "abracadabra" into an object equivalent to the notation (quote abracadabra).
The second quotation mark adds another layer of quote, turning the expression ''abracadabra into the list 
(quote (quote abracadabra)).

When we apply car to this list, we get the first element, which is the symbol quote. Thus, in Lisp, 
quotation marks are syntactic sugar that simplifies the notation of expressions with quote.
|#

(newline) (display (car (''abracadabra))) ; quote
(newline) (display (cdr (''abracadabra))) ; error! object: (quote abracadabra)