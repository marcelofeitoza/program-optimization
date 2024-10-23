use borsh::{BorshDeserialize, BorshSerialize};
use solana_program::{
    account_info::{next_account_info, AccountInfo},
    entrypoint,
    entrypoint::ProgramResult,
    msg,
    program_error::ProgramError,
    pubkey::Pubkey,
};

entrypoint!(process_instruction);

pub fn process_instruction(
    program_id: &Pubkey,
    accounts: &[AccountInfo],
    instruction_data: &[u8],
) -> ProgramResult {
    let instruction = CounterInstruction::unpack(instruction_data)
        .map_err(|_| ProgramError::InvalidInstructionData)?;

    match instruction {
        CounterInstruction::InitializeCounter => {
            msg!("Instruction: InitializeCounter");
            initialize_counter(program_id, accounts)
        }
        CounterInstruction::IncrementCounter => {
            msg!("Instruction: IncrementCounter");
            increment_counter(program_id, accounts)
        }
        CounterInstruction::DecrementCounter => {
            msg!("Instruction: DecrementCounter");
            decrement_counter(program_id, accounts)
        }
    }
}

pub enum CounterInstruction {
    InitializeCounter,
    IncrementCounter,
    DecrementCounter,
}

impl CounterInstruction {
    pub fn unpack(input: &[u8]) -> Result<Self, ProgramError> {
        let (tag, _rest) = input.split_at(1);
        match tag[0] {
            0 => {
                msg!("CounterInstruction::InitializeCounter");
                Ok(CounterInstruction::InitializeCounter)
            }
            1 => {
                msg!("CounterInstruction::IncrementCounter");
                Ok(CounterInstruction::IncrementCounter)
            }
            2 => {
                msg!("CounterInstruction::DecrementCounter");
                Ok(CounterInstruction::DecrementCounter)
            }
            _ => Err(ProgramError::InvalidInstructionData),
        }
    }
}

#[derive(BorshSerialize, BorshDeserialize)]
pub struct CounterAccount {
    pub count: u64,
}

fn initialize_counter(program_id: &Pubkey, accounts: &[AccountInfo]) -> ProgramResult {
    let accounts_iter = &mut accounts.iter();
    let counter_account = next_account_info(accounts_iter)?;

    if counter_account.owner != program_id {
        return Err(ProgramError::IncorrectProgramId);
    }

    let mut counter_data = CounterAccount::try_from_slice(&counter_account.data.borrow())?;
    counter_data.count = 0;
    counter_data.serialize(&mut &mut counter_account.data.borrow_mut()[..])?;

    msg!("Counter initialized to 0");
    Ok(())
}

fn increment_counter(program_id: &Pubkey, accounts: &[AccountInfo]) -> ProgramResult {
    let accounts_iter = &mut accounts.iter();
    let counter_account = next_account_info(accounts_iter)?;

    if counter_account.owner != program_id {
        return Err(ProgramError::IncorrectProgramId);
    }

    let mut counter_data = CounterAccount::try_from_slice(&counter_account.data.borrow())?;
    counter_data.count += 1;
    counter_data.serialize(&mut &mut counter_account.data.borrow_mut()[..])?;

    msg!("Counter incremented to {}", counter_data.count);
    Ok(())
}

fn decrement_counter(program_id: &Pubkey, accounts: &[AccountInfo]) -> ProgramResult {
    let accounts_iter = &mut accounts.iter();
    let counter_account = next_account_info(accounts_iter)?;

    if counter_account.owner != program_id {
        return Err(ProgramError::IncorrectProgramId);
    }

    let mut counter_data = CounterAccount::try_from_slice(&counter_account.data.borrow())?;

    if counter_data.count == 0 {
        msg!("Counter is already 0");
        return Err(ProgramError::Custom(1));
    }

    counter_data.count -= 1;
    counter_data.serialize(&mut &mut counter_account.data.borrow_mut()[..])?;

    msg!("Counter decremented to {}", counter_data.count);
    Ok(())
}
