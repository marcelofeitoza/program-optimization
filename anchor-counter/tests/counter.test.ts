import * as anchor from "@coral-xyz/anchor";
import { Program } from "@coral-xyz/anchor";
import { PublicKey, Keypair, LAMPORTS_PER_SOL } from "@solana/web3.js";
import { Counter } from "../target/types/counter";
import { expect } from "chai";

describe("counter", () => {
    const provider = anchor.AnchorProvider.env();
    anchor.setProvider(provider);
    const program = anchor.workspace.Counter as Program<Counter>;

    let counterAccount: Keypair;

    const airdropSol = async (pubkey: PublicKey, amount: number) => {
        const signature = await provider.connection.requestAirdrop(
            pubkey,
            amount * LAMPORTS_PER_SOL
        );
        await provider.connection.confirmTransaction(signature);
    };

    async function logTransactionDetails(
        connection: anchor.web3.Connection,
        signature: string
    ) {
        await connection.confirmTransaction(signature, "confirmed");

        const txDetails = await connection.getTransaction(signature, {
            commitment: "confirmed",
        });

        if (txDetails && txDetails.meta) {
            console.log("Transaction Logs:", txDetails.meta.logMessages);
        } else {
            console.log("No transaction details found for signature:", signature);
        }
    }

    beforeEach(async () => {
        counterAccount = Keypair.generate();

        await airdropSol(provider.wallet.publicKey, 1);

        const signature = await program.methods
            .initializeCounter()
            .accounts({
                counter: counterAccount.publicKey,
                user: provider.wallet.publicKey,
            })
            .signers([counterAccount])
            .rpc();

        await logTransactionDetails(provider.connection, signature);
    });

    it("initializes the counter to 0", async () => {
        const counter = await program.account.counter.fetch(
            counterAccount.publicKey
        );

        expect(counter.count.toNumber()).to.equal(0);
    });

    it("increments the counter", async () => {
        const signature = await program.methods
            .incrementCounter()
            .accounts({
                counter: counterAccount.publicKey,
            })
            .rpc();

        await logTransactionDetails(provider.connection, signature);

        const counter = await program.account.counter.fetch(
            counterAccount.publicKey
        );

        expect(counter.count.toNumber()).to.equal(1);
    });

    it("decrements the counter", async () => {
        let signature = await program.methods
            .incrementCounter()
            .accounts({
                counter: counterAccount.publicKey,
            })
            .rpc();
        await logTransactionDetails(provider.connection, signature);

        signature = await program.methods
            .decrementCounter()
            .accounts({
                counter: counterAccount.publicKey,
            })
            .rpc();
        await logTransactionDetails(provider.connection, signature);

        const counter = await program.account.counter.fetch(
            counterAccount.publicKey
        );

        expect(counter.count.toNumber()).to.equal(0);
    });
});