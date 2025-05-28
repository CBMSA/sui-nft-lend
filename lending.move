
module sui_nft_lend::lending {
    use sui::object::{Self, UID};
    use sui::tx_context::TxContext;
    use sui::balance;
    use sui::coin::{Coin};
    use sui::nft::{NFT};

    struct Loan has key {
        id: UID,
        borrower: address,
        nft: NFT,
        amount: u64,
        repaid: bool,
    }

    public fun initialize_loan(nft: NFT, amount: u64, ctx: &mut TxContext): Loan {
        Loan {
            id: object::new(ctx),
            borrower: tx_context::sender(ctx),
            nft,
            amount,
            repaid: false,
        }
    }

    public fun repay_loan(loan: &mut Loan, payment: u64) {
        assert!(!loan.repaid, 0);
        assert!(payment >= loan.amount, 1);
        loan.repaid = true;
    }
}