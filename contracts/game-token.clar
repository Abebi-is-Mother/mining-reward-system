;; Deolax Token - SIP-010 Fungible Token for Mining Reward RPG
;; Players earn $DEOLAX through gameplay and can spend it in-game or withdraw it
;; File name: contracts/game-token.clar

;; Import the trait first
(use-trait ft-token-trait .token-trait.ft-trait)

;; Define contract owner
(define-constant contract-owner tx-sender)

;; Error Codes
(define-constant ERR_NOT_AUTHORIZED (err u401))
(define-constant ERR_INSUFFICIENT_BALANCE (err u402))
(define-constant ERR_NOT_TOKEN_OWNER (err u403))

;; Token Metadata
(define-constant token-name "Deolax")
(define-constant token-symbol "DEOLAX")
(define-constant token-decimals u6)
(define-constant token-uri u"https://deolax.game/token-metadata.json")

;; Token Ledger
(define-data-var total-supply uint u0)
(define-map balances { account: principal } uint)

;; Implementation
(define-public (transfer (recipient principal) (amount uint))
  (let ((sender-balance (default-to u0 (map-get? balances { account: tx-sender }))))
    (if (>= sender-balance amount)
      (begin
        (map-set balances { account: tx-sender } (- sender-balance amount))
        (map-set balances { account: recipient } 
          (+ (default-to u0 (map-get? balances { account: recipient })) amount))
        (ok true))
      (err ERR_INSUFFICIENT_BALANCE))))

(define-public (transfer-memo (recipient principal) (amount uint) (memo (buff 34)))
  (begin
    (print memo)
    (transfer recipient amount)))

(define-read-only (get-name)
  (ok token-name))

(define-read-only (get-symbol)
  (ok token-symbol))

(define-read-only (get-decimals)
  (ok token-decimals))

(define-read-only (get-balance (account principal))
  (ok (default-to u0 (map-get? balances { account: account }))))

(define-read-only (get-total-supply)
  (ok (var-get total-supply)))

(define-read-only (get-token-uri)
  (ok (some token-uri)))

;; Authorization helper (only contract deployer can mint)
(define-private (is-authorized (sender principal))
  (is-eq sender contract-owner))

;; Mint new Deolax tokens to a user (only contract-owner or mining-engine should call this)
(define-public (mint (recipient principal) (amount uint))
  (if (is-authorized tx-sender)
    (begin
      (map-set balances { account: recipient }
        (+ amount (default-to u0 (map-get? balances { account: recipient }))))
      (var-set total-supply (+ amount (var-get total-supply)))
      (ok true))
    (err ERR_NOT_AUTHORIZED)))

;; Burn tokens from sender's balance (e.g., spending or destruction)
(define-public (burn (amount uint))
  (let ((balance (default-to u0 (map-get? balances { account: tx-sender }))))
    (if (>= balance amount)
      (begin
        (map-set balances { account: tx-sender } (- balance amount))
        (var-set total-supply (- (var-get total-supply) amount))
        (ok true))
      (err ERR_INSUFFICIENT_BALANCE))))