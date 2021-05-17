#lang racket

(provide (all-defined-out))

; empty list : null
; const constructor : cons
; head : car
; tail : cdr
; check if empty : null?
; build multi element list sugar: (list e1 ... en)

(define (sum xs)
  (if (null? xs)
    0
    (+ (car xs) (sum (cdr xs)))))

(define (my-append xs ys)
  (if (null? xs)
    ys
    (cons (car xs) (my-append (cdr xs) ys))))

(define (my-map f xs)
  (if (null? xs)
    null
    (cons (f (car xs)) (my-map f (cdr xs)))))

;> (define x (list 1 2 3))
;> (my-map (lambda (y) (+ y 1)) x)
