#lang racket

(define i 0)

(define one-by-one
  (lambda ()
    (begin (set! i (+ i 1))
           (mcons i one-by-one))))


(define (take stream x)
  (if (= x 0)
      null
      (let ([pr (stream)])
       (cons (mcar pr) (take (mcdr pr) (- x 1))))))