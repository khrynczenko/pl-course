#lang racket

(define (Const i) (list 'Const i)) ;; We introduce symbols with a single quotation mark
                                   ;; We can also build our daatatypes with lists
                                   ;; that have symbol in their first element,
                                   ;; as if it would be a tag.

(define (Const? x) (eq? (car x) 'Const)) ;; Symbols are similar to haskel but the compare
                                         ;; much faster because they will be represented
                                         ;; internally not as strings but for example integers
(define (Const-int x) (car (cdr x)))