(define _x car)
(define _y cdr)
(define point cons)

;;; (rappend ls0 ls1)
;;; (rappend '(1 2 3) '(4 5 6)) -> (3 2 1 4 5 6)
(define (rappend ls0 ls1)
  (let loop((ls0 ls0) (ls1 ls1))
    (if (null? ls0)
        ls1
        (loop (cdr ls0) (cons (car ls0) ls1)))))

;;; (devide p1 p2 r)
;;; dividing p1 and p2 internally by the ratio r
(define (divide p1 p2 r)
  (point (+ (* r (_x p1)) (* (- 1.0 r) (_x p2)))
         (+ (* r (_y p1)) (* (- 1.0 r) (_y p2)))))

;;; (print-curve points fout)
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

;;(a b) --> (a c b) --> (a d c e b)
;;
;;details of (a c b) --> (a d c e b):
;;points = (a c b); acc = ()        --> result_of_proc = (a d); acc = ()    --> acc = (d a)
;;points = (c b);   acc = (d a)     --> result_of_proc = (c e); acc = (d a) --> acc = (e c d a)
;;points = (b);     acc = (e c d a) --> (a d c e b)
(define (fractal proc n points fout)
  (let loop ((i 0) (points points))
    (display i)
    (newline)
    (if (= n i)
        (print-curve points fout)
        (loop
         (1+ i)
         (let iter ((points points) (acc '()))
           (if (null? (cdr points))
               (reverse! (cons (car points) acc))
               (iter
                (cdr points)
                (rappend (proc (first points) (second points)) acc)))))))
  'done)

(define (c-curve p1 p2)
  (let ((p3 (divide p1 p2 0.5)))
    (list
     p1
     (point (+ (_x p3) (- (_y p3) (_y p2)))
            (+ (_y p3) (- (_x p2) (_x p3)))))))

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

(define (koch p1 p2)
  (let ((p3 (divide p1 p2 2/3))
        (p4 (divide p1 p2 1/3))
        (p5 (divide p1 p2 0.5))
        (c (/ (sqrt 3) 2)))
    (list
     p1
     p3
     (point (- (_x p5) (* c (- (_y p4) (_y p3))))
            (+ (_y p5) (* c (- (_x p4) (_x p3)))))
     p4)))
