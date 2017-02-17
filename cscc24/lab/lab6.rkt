(module lab6 scheme
  
;;; (my-reverse xs) -> list
;;; xs: list
;;; Return the reverse of xs. (Not tail-recursive.)
(define my-reverse-1
  (λ (xs)
    (if (empty? (rest xs)) (append (list(first xs)))
        (if (= 1 (length (rest xs))) (append (rest xs) (list(first xs)))
            (append (my-reverse-1 (rest xs)) (list(first xs)))))))

  ;;; tail-recursive version
(define my-reverse-2
  (λ (xs)
    (define (helper xs res)
      (if (empty? xs) res
          (helper (remove (last xs) xs) (append res (list (last xs)))))) (helper xs '())))


;;; (num-elts xs) -> int
;;; xs: list
;;; Return the number of elements in xs, including
;;; any sublists, on any nesting level.
;;; using recursion only, no tail recursion
(define num-els-1
  (λ (xs)
    (if (empty? xs) 0
        (if (list? (first xs)) (+ (num-els-1 (first xs)) (num-els-1 (rest xs)))
            (+ 1 (num-els-1 (rest xs)))))))

;;; using HOPs (and recursion)
;;; this solution should be much shorter!
(define num-els-2
  (λ (xs)
    42))


;;; tail-recursive version
(define num-els-3
  (λ (xs)
    (define (helper xs res)
      (if (empty? xs) res
          (if (list? (first xs)) (helper (rest xs) (helper (first xs) res))
              (helper (rest xs) (+ 1 res))))) (helper xs 0)))




;;; (flatten xs) -> list
;;; xs: list
;;; Return the flattened version of xs. 
;;; using recursion only, no tail recursion
(define flatten-1
  (λ (xs)
    (if (empty? xs) '()
        (if (list? (first xs)) (append (flatten-1 (first xs)) (flatten-1 (rest xs)))
            (append (list (first xs)) (flatten-1 (rest xs)))))))

;;; using HOPs (and recursion)
(define flatten-2
  (λ (xs)
    42))

;;; tail-recursive version
(define flatten-3
  (λ (xs)
    (define (iter xs res)
      (if (empty? xs) res
          (if (list? (first xs)) (iter (rest xs) (iter (first xs) res))
              (iter (rest xs) (append res (list (first xs))))))) (iter xs '())))

(provide my-reverse-1 my-reverse-2 num-els-1 num-els-2 num-els-3 flatten-1 flatten-2 flatten-3)
)
