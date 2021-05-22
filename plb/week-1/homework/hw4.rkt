#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below

; TASK 1
(define (sequence low high stride)
  (if (<= low high)
      (cons low (sequence (+ low stride) high stride))
      null))

; TASK 2
(define (string-append-map xs suffix)
  (map (lambda (s) (string-append s suffix)) xs))

; TASK 3
(define (list-nth-mod xs nth)
  (if (< nth 0)
      (error "list-nth-mod: negative number")
      (if (empty? xs)
          (error "list-nth-mod: empty list")
          (let ([i (remainder nth (length xs))])
            (car (list-tail xs i))))))

; TASK 4
(define (stream-for-n-steps s n)
  (let ([pr (s)])
    (if (> n 0)
        (cons (car pr) (stream-for-n-steps (cdr pr) (- n 1)))
        null)))

; TASK 5
(define (funny-number-stream)
  (letrec ([f (lambda (n)
                (if (= (modulo n 5) 0)
                    (cons (- 0 n) (lambda () (f (+ n 1))))
                    (cons n (lambda () (f (+ n 1))))))])
    (f 1)))

; TASK 6
(define (dan-then-dog)
  (letrec ([f (lambda (name)
                (if (string=? name "dan.jpg")
                    (cons "dan.jpg" (lambda () (f "dog.jpg")))
                    (cons "dog.jpg" (lambda () (f "dan.jpg")))))])
    (f "dan.jpg")))

; TASK 7
(define (stream-add-zero s)
  (let* ([pr (s)]
         [f (lambda ()
              (cons (cons 0 (car pr)) (stream-add-zero (cdr pr))))])
    f))

; TASK 8
(define (next xs n)
  (if (>= (+ n 1) (length xs))
      0
      (+ n 1)))

(define (cycle-lists xs ys)
  (letrec ([f (lambda (xi yi)
                (cons (cons (list-ref xs xi) (list-ref ys yi)) (lambda () (f (next xs xi) (next ys yi))))
                )])
    (lambda () (f 0 0))))

; TASK 9
(define (vector-assoc v vec)
  (letrec ([go (lambda (v vec n)
                 (if (>= n (vector-length vec))
                     #f
                     (if (equal? v (car (vector-ref vec n)))
                         (vector-ref vec n)
                         (go v vec (+ n 1)))))])
    (go v vec 0)))


; TASK 10

(define (nextv xs n)
  (if (>= (+ n 1) (vector-length xs))
      0
      (+ n 1)))

(define (cached-assoc xs n)
  (let ([cache (make-vector n (cons #f #f))]
        [i (- 0 1)])
    (let ([f (lambda (v)
               (let ([found-cache (vector-assoc v cache)])
                 (if found-cache
                     found-cache
                     (let ([found (assoc v xs)])
                       (if found
                           (begin
                             (vector-set! cache (nextv cache i) found)
                             (set! i (nextv cache i))
                             found)
                           #f)))))])
      f)))

; TASK 11

(define-syntax while-less
  (syntax-rules (do)
    [(while-less e1 do e2)
     (let ([x e1])
       (letrec ([loop (lambda ()
                        (if (< e2 x)
                            (loop)
                            #t))])
         (loop)))]))