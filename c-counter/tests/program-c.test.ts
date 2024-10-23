import {
	Connection,
	Keypair,
	LAMPORTS_PER_SOL,
	PublicKey,
	SendTransactionError,
	SystemProgram,
	Transaction,
	TransactionInstruction,
	VersionedTransaction,
} from "@solana/web3.js";
import { Buffer } from "buffer";
import { expect } from "chai";

describe("program c counter", () => {
	const programId = new PublicKey(
		"FnEnKRysLRFevxjKePUfGEircDEpvnAT8EERmTvWhRgF"
	);
	const connection = new Connection("http://localhost:8899", "confirmed");

	let counterAccount: Keypair;
	let keyPair: Keypair;

	before(async () => {
		keyPair = Keypair.generate();
		const airdropSignature = await connection.requestAirdrop(
			keyPair.publicKey,
			10 * LAMPORTS_PER_SOL
		);
		await connection.confirmTransaction(airdropSignature);
	});

	beforeEach(async () => {
		try {
			counterAccount = Keypair.generate();
			const tx = new Transaction();

			const initializeData = Buffer.from([0]);

			tx.add(
				SystemProgram.createAccount({
					fromPubkey: keyPair.publicKey,
					newAccountPubkey: counterAccount.publicKey,
					lamports:
						await connection.getMinimumBalanceForRentExemption(8),
					space: 8,
					programId: programId,
				}),
				new TransactionInstruction({
					programId,
					keys: [
						{
							pubkey: counterAccount.publicKey,
							isSigner: false,
							isWritable: true,
						},
					],
					data: initializeData,
				})
			);

			tx.recentBlockhash = (
				await connection.getLatestBlockhash("confirmed")
			).blockhash;
			tx.feePayer = keyPair.publicKey;

			const versionedTx = new VersionedTransaction(tx.compileMessage());
			versionedTx.sign([keyPair, counterAccount]);

			const signature = await connection.sendTransaction(versionedTx, {
				skipPreflight: false,
				preflightCommitment: "confirmed",
			});

			await connection.confirmTransaction(
				{
					signature,
					lastValidBlockHeight: (
						await connection.getLatestBlockhash("confirmed")
					).lastValidBlockHeight,
					blockhash: tx.recentBlockhash,
				},
				"confirmed"
			);

			// Log compute units used during initialization
			await logTransactionDetails(connection, signature);
		} catch (error: any) {
			console.error("Error in beforeEach:", error);
			if (error instanceof SendTransactionError) {
				console.error(
					"Transaction error:",
					await error.getLogs(connection)
				);
			}
			throw error;
		}
	});

	// Helper function to log transaction details
	async function logTransactionDetails(
		connection: Connection,
		signature: string
	) {
		const txDetails = await connection.getTransaction(signature, {
			commitment: "confirmed",
		});

		if (txDetails && txDetails.meta) {
			console.log("Transaction Logs:", txDetails.meta.logMessages);
		}
	}

	async function sendInstruction(
		connection: Connection,
		programId: PublicKey,
		keyPair: Keypair,
		counterAccount: PublicKey,
		data: Buffer
	): Promise<string> {
		const tx = new Transaction().add(
			new TransactionInstruction({
				programId,
				keys: [
					{
						pubkey: counterAccount,
						isSigner: false,
						isWritable: true,
					},
				],
				data: data,
			})
		);

		tx.recentBlockhash = (
			await connection.getLatestBlockhash("confirmed")
		).blockhash;
		tx.feePayer = keyPair.publicKey;

		const versionedTx = new VersionedTransaction(tx.compileMessage());
		versionedTx.sign([keyPair]);

		const signature = await connection.sendTransaction(versionedTx, {
			skipPreflight: false,
			preflightCommitment: "confirmed",
		});
		await connection.confirmTransaction(signature, "confirmed");

		return signature;
	}

	// ... (rest of your test cases with added logging)

	it("increments the counter", async () => {
		const incrementData = Buffer.from([1]);
		const signature = await sendInstruction(
			connection,
			programId,
			keyPair,
			counterAccount.publicKey,
			incrementData
		);

		// Log compute units used
		await logTransactionDetails(connection, signature);

		const counterData = await connection.getAccountInfo(
			counterAccount.publicKey
		);
		expect(counterData).to.not.be.null;
		if (counterData && counterData.data) {
			const counter = counterData.data.readBigUInt64LE(0);
			expect(Number(counter)).to.equal(1);
		}
	});

	it("decrements the counter", async () => {
		const incrementData = Buffer.from([1]);
		await sendInstruction(
			connection,
			programId,
			keyPair,
			counterAccount.publicKey,
			incrementData
		);

		const decrementData = Buffer.from([2]);
		const signature = await sendInstruction(
			connection,
			programId,
			keyPair,
			counterAccount.publicKey,
			decrementData
		);

		await logTransactionDetails(connection, signature);

		const counterData = await connection.getAccountInfo(
			counterAccount.publicKey
		);
		expect(counterData).to.not.be.null;
		if (counterData && counterData.data) {
			const counter = counterData.data.readBigUInt64LE(0);
			expect(Number(counter)).to.equal(0);
		}
	});

	it("throws error when decrementing the counter at 0", async () => {
		const decrementData = Buffer.from([2]);

		try {
			const signature = await sendInstruction(
				connection,
				programId,
				keyPair,
				counterAccount.publicKey,
				decrementData
			);

			await logTransactionDetails(connection, signature);

			throw new Error("Decrement should have failed, but it succeeded.");
		} catch (error: any) {
			expect(error.message).to.include(
				"Counter is already 0, cannot decrement"
			);
		}
	});
});
