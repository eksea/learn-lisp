#lang racket
(require srfi/1)

(define _x car)
(define _y cdr)
(define point cons)

;; (rappend ls0 ls1)
;; (rappend '(1 2 3) '(4 5 6)) -> (3 2 1 4 5 6)
(define (rappend ls0 ls1)
  (let loop((ls0 ls0) (ls1 ls1))
    (if (null? ls0)
        ls1
        (loop (cdr ls0) (cons (car ls0) ls1)))))

;; (devide p1 p2 r)
;; dividing p1 and p2 internally by the ratio r.
(define (divide p1 p2 r)
  (point (+ (* r (_x p1)) (* (- 1.0 r) (_x p2)))
         (+ (* r (_y p1)) (* (- 1.0 r) (_y p2)))))

;; (print-curve points fout)
;; output the points to file
(define (print-curve points fout)
  (with-output-to-file fout
    (lambda ()
      (for-each
       (lambda (p)
         (display (_x p))
         (display " ")
         (display (_y p))
         (newline))
         points))))

;; implement of "1+"
(define-syntax incf
  (syntax-rules ()
    ((_ x) (begin (set! x (+ x 1)) x))
    ((_ x n) (begin (set! x (+ x n)) x))))

(define (fractal proc n points fout)
  (let loop ((i 0) (pionts points))
    (if (= n 1)
        (print-curve points fout)
        (loop
         (incf i)
         (let iter ((points points) (acc '()))
           (if (null? (cdr points))
               (reverse! (cons (car points) acc))
               (iter
                (cdr points)
                (rappend (proc (first points) (second points)) acc)))))))
  'done)

;; c-curves locating func
(define (c-curve p1 p2)
  (let ((p3 (divide p1 p2 0.5)))
    (list
     p1
     (point (+ (_x p3) (- (_y p3)(_y p2)))
            (+ (_y p3) (- (_x p2) (_x p3)))))))

;; dragon-curve locating func
(define dragon-curve
  (let ((n 0))
    (lambda (p1 p2)
      (let ((op (if (even? n) + -))
            (p3 (divide p1 p2 0.5)))
        (set! n (1+ n))
        (list
         p1
         (point (op (_x p3) (- (_y p3) (_y p2)))
                (op (_y p3) (- (_x p2) (_x p3)))))))))





















