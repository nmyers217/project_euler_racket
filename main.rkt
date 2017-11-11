#lang racket

(require racket/trace)


;; Problem 1
(define (euler-one)
  (define (f sum x)
    (cond [(>= x 1000) sum]
          [(or (zero? (modulo x 3))
               (zero? (modulo x 5)))
           (f (+ sum x) (+ x 1))]
          [else (f sum (+ x 1))]))
  (f 0 1))


;; Problem 2
(define (euler-two)
  ; A stream of fibonacci numbers
  (define (fibs)
    (define (f cur prev)
      (cons cur (λ () (f (+ prev cur) cur))))
    (λ () (f 1 1)))

  ; An implementation of foldl for streams that accepts a predicate
  (define (fold-while predicate proc acc a-stream )
    (let* ([cell (a-stream)]
           [head (car cell)]
           [tail (cdr cell)])
      (if (predicate acc head)
          (fold-while predicate proc (proc acc head) tail)
          acc)))

  ; fold the fibs adding evens to the sum until we get over 4000000
  (define (f)
    (fold-while (λ (acc val) (<= val 4000000))
                (λ (acc val) (if (even? val) (+ acc val) acc))
                0
                (fibs)))
  (f))