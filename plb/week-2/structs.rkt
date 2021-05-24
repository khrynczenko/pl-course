#lang racket

(struct const (int) #:transparent) 
;; gets us thre functions
;; constructor `const`
;; tester `const?`
;; accessor `const-int`

(define x (const 1))
(print (const? x))
(print (const? 1))
(print (const-int x))

; #:transparent attribute changes behaviour of printing, it will print whole structure nicely
; #:mutable adds mutating accessors