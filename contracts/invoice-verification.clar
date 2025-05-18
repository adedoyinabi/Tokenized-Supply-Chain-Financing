;; Invoice Verification Contract
;; This contract records and validates invoice information

(define-data-var admin principal tx-sender)
(define-data-var invoice-counter uint u0)

;; Data map to store invoice information
(define-map invoices
  uint
  {
    supplier: principal,
    buyer: principal,
    amount: uint,
    due-date: uint,
    verified: bool,
    paid: bool,
    creation-date: uint
  }
)

;; Create a new invoice
(define-public (create-invoice
                (buyer principal)
                (amount uint)
                (due-date uint))
  (let ((caller tx-sender)
        (invoice-id (+ (var-get invoice-counter) u1)))

    ;; Increment the invoice counter
    (var-set invoice-counter invoice-id)

    ;; Store the invoice
    (ok (map-set invoices invoice-id {
      supplier: caller,
      buyer: buyer,
      amount: amount,
      due-date: due-date,
      verified: false,
      paid: false,
      creation-date: block-height
    }))
  )
)

;; Verify an invoice (admin or buyer only)
(define-public (verify-invoice (invoice-id uint))
  (let ((caller tx-sender))
    (match (map-get? invoices invoice-id)
      invoice-data
        (begin
          (asserts! (or
                      (is-eq caller (var-get admin))
                      (is-eq caller (get buyer invoice-data)))
                    (err u403))
          (ok (map-set invoices
                invoice-id
                (merge invoice-data { verified: true }))))
      (err u404) ;; Invoice not found
    )
  )
)

;; Mark invoice as paid (admin or buyer only)
(define-public (mark-invoice-paid (invoice-id uint))
  (let ((caller tx-sender))
    (match (map-get? invoices invoice-id)
      invoice-data
        (begin
          (asserts! (or
                      (is-eq caller (var-get admin))
                      (is-eq caller (get buyer invoice-data)))
                    (err u403))
          (ok (map-set invoices
                invoice-id
                (merge invoice-data { paid: true }))))
      (err u404) ;; Invoice not found
    )
  )
)

;; Get invoice details
(define-read-only (get-invoice (invoice-id uint))
  (map-get? invoices invoice-id)
)

;; Transfer admin rights
(define-public (set-admin (new-admin principal))
  (let ((caller tx-sender))
    (asserts! (is-eq caller (var-get admin)) (err u403))
    (ok (var-set admin new-admin))
  )
)
