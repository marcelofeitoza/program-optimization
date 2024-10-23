use anchor_lang::prelude::*;

declare_id!("HPeVb59xsfeFCBG6ags7jWdbVh3yFcBVaCcVjUJDg95D");

#[program]
pub mod counter {
    use super::*;

    pub fn initialize_counter(ctx: Context<InitializeCounter>) -> Result<()> {
        let counter = &mut ctx.accounts.counter;
        counter.count = 0;
        Ok(())
    }

    pub fn increment_counter(ctx: Context<IncrementCounter>) -> Result<()> {
        let counter = &mut ctx.accounts.counter;
        counter.count += 1;
        Ok(())
    }

    pub fn decrement_counter(ctx: Context<DecrementCounter>) -> Result<()> {
        let counter = &mut ctx.accounts.counter;
        counter.count -= 1;
        Ok(())
    }
}

#[derive(Accounts)]
pub struct InitializeCounter<'info> {
    #[account(init, payer = user, space = 8 + 8)]
    pub counter: Account<'info, Counter>,
    #[account(mut)]
    pub user: Signer<'info>,
    pub system_program: Program<'info, System>,
}

#[derive(Accounts)]
pub struct IncrementCounter<'info> {
    #[account(mut)]
    pub counter: Account<'info, Counter>,
}

#[derive(Accounts)]
pub struct DecrementCounter<'info> {
    #[account(mut)]
    pub counter: Account<'info, Counter>,
}

#[account]
pub struct Counter {
    pub count: u64,
}
