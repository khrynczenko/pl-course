#lang racket

; eager
(define work
  (lambda (x y)
    (if (= x 0)
        0
        (+ y (work (- x 1) y)))))

; y thunked

(define work2
  (lambda (x p)
    (if (= x 0)
        0
        (+ (p) (work2 (- x 1) p)))))

; Delay and Force

(define my-delay
  (lambda (f)
    (mcons #f f)))

(define my-force
  (lambda (p)
    (if (mcar p)
        (mcdr p)
        (begin (set-mcar! p #t)
               (set-mcdr! p ((mcdr p)))
               (mcdr p)))))

(define work3
  (lambda (x p)
    (if (= x 0)
        0
        (+ (my-force p) (work3 (- x 1) p)))))