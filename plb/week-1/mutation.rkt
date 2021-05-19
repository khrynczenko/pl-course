#lang racket

(define c 5)
(define f
  (lambda (x) (+ x c)))
(define before_mut (f 1))
(set! c 10)
(define after_mut (f 1))

(define after_mut2
  (begin (set! c 15) (f 1)))

; regular lists are built using cons
(define const-list (cons 1 (cons 2 null)))
(define const-list-alias const-list) ; const-list value is taken here and bound to a name const-list-alias
(set! const-list (cons 2 (cons 3 null))) ; we bind new value to const-list but const-list aliast already had its own value

; mutable lists are built using mcons
(define mut-list (mcons 1 (mcons 2 null)))
(define mut-list-alias mut-list)
(set-mcar! mut-list 2)