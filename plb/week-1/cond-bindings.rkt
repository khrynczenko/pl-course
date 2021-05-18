#lang racket

(define x 1)

(define y (cond [(number? x) "is number"]
                [(list? x) "is list"]
                [#t "is something else"]))

; regular let expression uses enviroment available at the point of definition (before the let expression) (xn cannot use xn-1)
; (let ([x1 e1] [xn en]) (body))

; let* expression uses enviroment available at the point of definition  but each new binding uses binding also untroduced in the let expression
; (let ([x1 e1] [xn en]) (body))

; letrec is used for mutual recursion only

(define (plus-three-define x)
  (define y 3)
  (+ y x))

(define (plus-three-let x)
  (let ([y 3])
  (+ y x)))

(define (plus-three-letrec x)
  (let* ([z 3]
         [y z])
    (+ y x)))