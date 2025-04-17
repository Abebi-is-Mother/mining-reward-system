;; Deolax Token - SIP-010 Fungible Token for Mining Reward RPG
;; Players earn $DEOLAX through gameplay and can spend it in-game or withdraw it

(impl-trait 'SP3FBR2AGK7Q1N0MNZGH4CP6FJ5B7HZ3N2C7P7CJD.token-trait.token-trait)

;; Error Codes
(define-constant ERR_NOT_AUTHORIZED (err u401))
(define-constant ERR_INSUFFICIENT_BALANCE (err u402))

;; Token Metadata
(define-constant token-name "Deolax")
(define-constant token-symbol "DEOLAX")
(define-constant token-decimals u6)

;; Token Ledger
(define-data-var total-supply uint u0)
(define-map balances { account: principal } uint)
(define-map allowances { owner: principal, spender: principal } uint)

;; Metadata Getters
(define-read-only (get-name) token-name)
(define-read-only (get-symbol) token-symbol)
(define-read-only (get-decimals) token-decimals)
(define-read-only (get-total-supply) (ok (var-get total-supply)))

;; Balance Lookup
(define-read-only (get-balance (account principal))
  (ok (default-to u0 (map-get? balances { account: account }))))

;; Allowance Lookup
(define-read-only (get-allowance (owner principal) (spender principal))
  (ok (default-to u0 (map-get? allowances { owner: owner, spender: spender }))))

;; Authorization helper (only contract deployer can mint)
(define-private (is-authorized (sender principal))
  (is-eq sender (contract-owner)))

;; Internal transfer logic
(define-private (internal-transfer (sender principal) (recipient principal) (amount uint))
  (let (
    (sender-balance (default-to u0 (map-get? balances { account: sender })))
    (recipient-balance (default-to u0 (map-get? balances { account: recipient })))
  )
    (if (>= sender-balance amount)
      (begin
        (map-set balances { account: sender } (- sender-balance amount))
        (map-set balances { account: recipient } (+ recipient-balance amount))
        (ok true))
      ERR_INSUFFICIENT_BALANCE)))

;; Transfer token to another player
(define-public (transfer (recipient principal) (amount uint))
  (internal-transfer tx-sender recipient amount))

;; Mint new Deolax tokens to a user (only contract-owner or mining-engine should call this)
(define-public (mint (recipient principal) (amount uint))
  (if (is-authorized tx-sender)
    (begin
      (map-set balances { account: recipient }
        (+ amount (default-to u0 (map-get? balances { account: recipient }))))
      (var-set total-supply (+ amount (var-get total-supply)))
      (ok true))
    ERR_NOT_AUTHORIZED))

;; Burn tokens from sender's balance (e.g., spending or destruction)
(define-public (burn (amount uint))
  (let ((balance (default-to u0 (map-get? balances { account: tx-sender }))))
    (if (>= balance amount)
      (begin
        (map-set balances { account: tx-sender } (- balance amount))
        (var-set total-supply (- (var-get total-supply) amount))
        (ok true))
      ERR_INSUFFICIENT_BALANCE)))
