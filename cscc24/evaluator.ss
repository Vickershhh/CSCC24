(module evaluator scheme

  ; some helper functions that should make your code much easier to read
  (define unary-op first)
  (define operand second)
  (define binary-op second)
  (define left first)
  (define right third)
  (define (atomic? v) (not (list? v)))
  (define (unary? expr) (= 2 (length expr)))
  (define (binary? expr) (= 3 (length expr)))

  
  ; It is a good idea to define more such helpers here...
  (define x '(x and y))
  (define conj (binary-op x))
  (define (helper k m)
   (map (lambda (x) (* k x)) m))
  ; (evaluate expr context) -> boolean
  ; expr: a valid representation of an expression
  ; context: list of pairs: symbol to #t/#f
  ; Return the value of expr with values of all variables
  ; that occur in expr specified in context.
  (define evaluate
    (lambda (expr context)
      (if (atomic? expr) expr
          (if (unary? expr) (not (evaluate (operand expr) context))
              (if (binary? expr)
                  (if (eq? conj (binary-op expr)) (and (evaluate (left expr) context) (evaluate (right expr) context))
                      (or (evaluate (left expr) context) (evaluate (right expr) context)))1))) ))

  ; (simplify expr context) -> valid expression
  ; expr: a valid representation of an expression
  ; context: list of pairs: symbol to #t/#f
  ; Return an expression that is equivalent to expr,
  ; but is simplified as much as possible, according to
  ; the given rules.
  (define simplify
    (lambda (expr context)
      42))
  
  (provide evaluate simplify) 
  )