;; SIP-010 Trait Definition for Fungible Tokens
;; File name: contracts/token-trait.clar

;; Define the official SIP-010 trait
(define-trait ft-trait
  (
    ;; Transfer from caller to a principal
    (transfer (principal uint) (response bool uint))
    
    ;; Transfer from specified principal to another principal
    (transfer-memo (principal uint (buff 34)) (response bool uint))
    
    ;; Get balance for a token holder
    (get-balance (principal) (response uint uint))
    
    ;; Get token supply
    (get-total-supply () (response uint uint))
    
    ;; Get token decimals
    (get-decimals () (response uint uint))
    
    ;; Get token name
    (get-name () (response (string-ascii 32) uint))
    
    ;; Get token symbol
    (get-symbol () (response (string-ascii 32) uint))
    
    ;; Get token URI
    (get-token-uri () (response (optional (string-utf8 256)) uint))
  )
)