#lang racket

(define c 5)
(define f
  (lambda (x) (+ x c)))
(define before_mut (f 1))
(set! c 10)
(define after_mut (f 1))

(define after_mut2
  (begin (set! c 15) (f 1)))