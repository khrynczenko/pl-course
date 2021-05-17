#lang racket

(provide (all-defined-out))

(define x 3)
(define y (+ x 2)) 

(define cube1
  (lambda (x)
    (* x (* x x))))

(define cube2
  (lambda (x)
    (* x x x))) ; arithmetic operator can be use with any number of arguments

(define (cube3 x) ; syntactic sugar for omitting lambda
  (* x x x))

(define (pow1 x y)
  (if (= y 0) ; if
    1 ; then
    (* x (pow1 x (- y 1))))) ; else

(define pow2 ; curried version
  (lambda (x)
    (lambda (y)
      (pow1 x y))))

(define three_to_power ; taking advantage of currying
  (pow2 3))
