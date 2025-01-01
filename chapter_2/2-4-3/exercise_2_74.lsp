#|
You can't run this code.

a. Let's imagine we have 2 departments with the following structures:
- lazy-department: '('(index employee-name)'(employee-address employee-salary))
- meticulous-department: '(employee-name 
    '(personal-info '(employee-address employee-phone))
    '(company-info '(salary position salary)))
So we just need to save the name of department and get-record will take the name of
employee and name of department.

d. First you need to update the list of departments. Second you need to create new package
for new department.
|#

(define (install-lazy-department)
    ;; internal procedures
    (define employees '(...))

    (define (get-record name employees)
        (cond
            ((null? employees) #f)
            ((eq? name (cadr (car employees))) (car employees))
            (else (get-record name (cdr employees)))))

    ;; external interface
    (define (tag x) (attach-tag 'lazy-department x))
    (put 'get-record '(lazy-department) (lambda (name) (get-record name employees)))
    (put 'get-salary '(lazy-department) (lambda (name) (cadr (cdr (get-record name employees)))))
    done)

(define (install-meticulous-department)
    ;; internal procedures
    (define employees '(...))

    (define (get-record name employees)
        (cond
            ((null? employees) #f)
            ((eq? name (car (car employees))) (car employees))
            (else (get-record name (cdr employees)))))
    
    (define (get-salary name employees)
        (cadr (cadr (cadr (get-record name employees)))))

    ;; external interface
    (define (tag x) (attach-tag 'meticulous-department x))
    (put 'get-record '(meticulous-department) (lambda (name) (get-record name employees)))
    (put 'get-salary '(meticulous-department) (lambda (name) (get-salary name employees)))
    done)

(define (get-record name department)
    ((get department 'get-record) name))

(define (get-salary name department)
    ((get department 'get-salary) name))

(define (find-employee-record name departments)
  (cond
    ((null? departments) (error "Employee not found -- FIND-EMPLOYEE-RECORD"))
    ((let ((record ((get (car departments) 'get-record) name)))
          (if record record (find-employee-record name (cdr departments)))))))

