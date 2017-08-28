#lang racket

(define vhello "Hello ")

(define fhello (lambda ()
                 vhello))

(define greet (lambda (name)
                (string-append vhello name)))

(define (another_greet name)
  (string-append vhello name))

(define (fact n)
  (if (= n 1)
      1
      (* n (fact (- n 1)))))



(define (fact-tail n)
  (fact-rec n n))

(define (fact-rec n p)
  (if (= n 1)
      p
      (let ((m (- n 1)))
        (fact-rec m (* p m)))))

(define (fact-let n)
  (let loop((n1 n) (p n))
    (if (= n1 1)
        p
        (let ((m (- n1 1)))
          (loop m (* p m))))))

(define (fact-letrec n)
  (letrec ((iter (lambda (n1 p)
                   (if (= n1 1)
                       p
                       (let ((m (- n1 1)))
                         (iter m (* p m)))))))
    (iter n n)))

(define (fact-do n)
  (do ((n1 n (- n1 1)) (p n (* p (- n1 1)))) ((= n1 1) p)))

(define (member-if proc ls)
  (cond
    ((null? ls) #f)
    ((proc (car ls)) ls)
    (else (member-if proc (cdr ls)))))

(define (member proc obj ls)
  (cond
    ((null? ls) #f)
    ((proc obj (car ls)) ls)
    (else (member proc obj (cdr ls)))))






