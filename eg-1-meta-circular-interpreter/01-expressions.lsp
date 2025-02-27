
#|
Самовычисляющиеся объекты:
- self-evaluating? проверяет, является ли выражение числом или 
строкой. Если да, оно считается самовычисляющимся.
|#
(define (self-evaluating? exp)
  (cond ((number? exp) true)
        ((string? exp) true)
        (else false)))

#|
Перемеменные:
- variable? проверяет, является ли выражение символом (переменной).
|#
(define (variable? exp) (symbol? exp))

#|
Кавычечные выражения:
- quoted? проверяет, является ли выражение кавыченным (quote). 
- text-of-quotation извлекает содержимое кавыченного выражения.
|#
(define (quoted? exp)
  (tagged-list? exp 'quote))

(define (text-of-quotation exp) (cadr exp))

#|
Используется для проверки, начинается ли список с определённого тега.
|#
(define (tagged-list? exp tag)
  (if (pair? exp)
      (eq? (car exp) tag)
      false))

#|
Присваивание:
- assignment? проверяет, является ли выражение присваиванием (set!).
- assignment-variable извлекает переменную, которой присваивается значение.
- assignment-value извлекает присваиваемое значение.
|#
(define (assignment? exp)
  (tagged-list? exp 'set!))

(define (assignment-variable exp) (cadr exp))

(define (assignment-value exp) (caddr exp))

#|
Определения:
- definition? проверяет, является ли выражение определением (define).
- definition-variable извлекает имя переменной или функции.
- definition-value получает либо присваиваемое значение 
(если определение переменной), либо создаёт лямбда-функцию 
(если определение процедуры).
|#
(define (definition? exp)
  (tagged-list? exp 'define))

(define (definition-variable exp)
  (if (symbol? (cadr exp))
      (cadr exp)
      (caadr exp)))

(define (definition-value exp)
  (if (symbol? (cadr exp))
      (caddr exp)
      (make-lambda (cdadr exp) (cddr exp))))

#|
Лямбда-выражения:
- lambda? проверяет, является ли выражение lambda.
- lambda-parameters извлекает список параметров функции.
- lambda-body извлекает тело функции.
- make-lambda создаёт lambda-выражение из параметров и тела.
|#
(define (lambda? exp) (tagged-list? exp 'lambda))

(define (lambda-parameters exp) (cadr exp))

(define (lambda-body exp) (cddr exp))

(define (make-lambda parameters body)
  (cons 'lambda (cons parameters body)))

#|
Условные выражения (if):
- if? проверяет, начинается ли выражение с if.
- if-predicate извлекает условие.
- if-consequent извлекает действие при true.
- if-alternative извлекает действие при false, если оно есть.
- make-if создаёт if-выражение из условий.
|#
(define (if? exp) (tagged-list? exp 'if))

(define (if-predicate exp) (cadr exp))

(define (if-consequent exp) (caddr exp))

(define (if-alternative exp)
  (if (not (null? (cdddr exp)))
      (cadddr exp)
      'false))

(define (make-if predicate consequent alternative)
  (list 'if predicate consequent alternative))

#|
Последовательности:
- begin? проверяет, является ли выражение begin.
- begin-actions извлекает последовательность действий.
- last-exp? проверяет, является ли выражение последним в 
последовательности.
- first-exp и rest-exps выделяют первое выражение и оставшиеся.
- sequence->exp преобразует список выражений в единое выражение,
используя begin, если необходимо.
- make-begin создаёт begin-выражение.
|#
(define (begin? exp) (tagged-list? exp 'begin))

(define (begin-actions exp) (cdr exp))

(define (last-exp? seq) (null? (cdr seq)))

(define (first-exp seq) (car seq))

(define (rest-exps seq) (cdr seq))

(define (sequence->exp seq)
  (cond ((null? seq) seq)
        ((last-exp? seq) (first-exp seq))
        (else (make-begin seq))))

(define (make-begin seq) (cons 'begin seq))

#|
Вызов процедур:
- application? проверяет, является ли выражение вызовом функции.
- operator извлекает оператор (функцию).
- operands извлекает список аргументов.
- no-operands? проверяет, есть ли аргументы.
- first-operand и rest-operands извлекают первый и оставшиеся аргументы.
|#
(define (application? exp) (pair? exp))

(define (operator exp) (car exp))

(define (operands exp) (cdr exp))

(define (no-operands? ops) (null? ops))

(define (first-operand ops) (car ops))

(define (rest-operands ops) (cdr ops))

#|
Производное выражение cond:

Определение cond:
- cond? проверяет, является ли выражение cond.
- cond-clauses извлекает список ветвей cond.

Обработка ветвей:
- cond-else-clause? проверяет, является ли ветка else.
- cond-predicate извлекает условие ветки.
- cond-actions получает действия ветки.

Преобразование cond в if
- cond->if вызывает expand-clauses, которая последовательно разбирает cond.
- expand-clauses проходит по веткам cond:
- Если cond пуст, возвращает false.
- Если встречает else, проверяет, что он последний. Если нет — выдаёт ошибку.
- Если это обычная ветка, создаёт if, комбинируя условие и действие.
|#
(define (cond? exp) (tagged-list? exp 'cond))

(define (cond-clauses exp) (cdr exp))

(define (cond-else-clause? clause)
  (eq? (cond-predicate clause) 'else))

(define (cond-predicate clause) (car clause))

(define (cond-actions clause) (cdr clause))

(define (cond->if exp)
  (expand-clauses (cond-clauses exp)))

(define (expand-clauses clauses)
  (if (null? clauses)
      'false
      (let ((first (car clauses))
            (rest (cdr clauses)))
        (if (cond-else-clause? first)
            (if (null? rest)
                (sequence->exp (cond-actions first))
                (error "Branch else is not last -- COND->IF" clauses))
            (make-if (cond-predicate first)
                     (sequence->exp (cond-actions first))
                     (expand-clauses rest))))))