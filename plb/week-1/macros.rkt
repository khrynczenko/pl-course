#lang racket

(define-syntax my-if ; new starting keyword
  (syntax-rules (then else) ; list of new keywords that our macro uses
    [(my-if e1 then e2 else e3) ; list of pairs where first element is new syntax, and second is expansion
     (if e1 e2 e3)]))

(define-syntax comment-out
  (syntax-rules ()
    [(comment-out e1 e2)
     e2]))

(define-syntax my-delay
  (syntax-rules ()
    [(my-delay e)
     (mcons #f (lambda () e))]))

(define (my-force p)
  (if (mcar p)
      (mcdr p)
      (begin (set-mcar! p #t)
             (set-mcdr! p ((mcdr p)))
             (mcdr p))))