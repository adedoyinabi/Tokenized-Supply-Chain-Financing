;; Credit Risk Assessment Contract
;; This contract evaluates payment reliability

(define-data-var admin principal tx-sender)

;; Data map to store credit scores
(define-map credit-scores
  principal
  {
    score: uint,
    last-updated: uint
  }
)

;; Set a credit score (admin only)
(define-public (set-credit-score (entity principal) (score uint))
  (let ((caller tx-sender))
    (asserts! (is-eq caller (var-get admin)) (err u403))
    (asserts! (<= score u100) (err u2)) ;; Score must be between 0-100

    (ok (map-set credit-scores entity {
      score: score,
      last-updated: block-height
    }))
  )
)

;; Get credit score
(define-read-only (get-credit-score (entity principal))
  (default-to
    { score: u0, last-updated: u0 }
    (map-get? credit-scores entity))
)

;; Check if entity is creditworthy (score >= 70)
(define-read-only (is-creditworthy (entity principal))
  (let ((score-data (get-credit-score entity)))
    (>= (get score score-data) u70)
  )
)

;; Transfer admin rights
(define-public (set-admin (new-admin principal))
  (let ((caller tx-sender))
    (asserts! (is-eq caller (var-get admin)) (err u403))
    (ok (var-set admin new-admin))
  )
)
