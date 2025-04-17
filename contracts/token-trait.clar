;; SIP-010 Trait Definition for Fungible Tokens
;; File: contracts/ft-trait.clar

(define-trait ft-trait
  (
    ;; Transfer from the caller to a new principal
    (transfer (principal uint) (response bool uint))

    ;; Get the token balance of the specified principal
    (get-balance (principal) (response uint uint))

    ;; Get the total number of tokens that exist
    (get-total-supply () (response uint uint))

    ;; Get human-readable name of the token
    (get-name () (string-ascii 32))

    ;; Get the symbol/ticker of the token
    (get-symbol () (string-ascii 32))

    ;; Get the precision used in the token amounts
    (get-decimals () uint)
  )
)