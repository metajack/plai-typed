#lang plai-typed

(define x '(a 2 "c" '(d)))

(print-only-errors #t)

(test #t (list? x))
(test #f (string? x))
(test #f (symbol? x))
(test #f (number? x))
(test (symbol->s-exp 'a) (first (s-exp->list x)))
(test #t (symbol? (first (s-exp->list x))))
(test #t (number? (first (rest (s-exp->list x)))))
(test #t (string? (first (rest (rest (s-exp->list x))))))
(test #t (list? (first (rest (rest (rest (s-exp->list x)))))))
(test #t (string? (string->s-exp "a")))
(test #t (number? (number->s-exp 2)))
(test #t (list? (list->s-exp (list))))
(test #t (list? (list->s-exp (list (number->s-exp 2)))))

(test 5 (local [(define x 10)]
          (begin
            (set! x 5)
            x)))

(test 5 (call/cc (lambda (x) 5)))
(test 7 (local [(define y (lambda (q) (+ q 3)))]
          (if (= 0 (call/cc (lambda (k)
                              (begin
                                (set! y k)
                                0))))
              (y 2)
              7)))