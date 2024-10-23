#include <solana_sdk.h>

enum CounterInstructions
{
	InitializeCounter, // 0
	IncrementCounter,  // 1
	DecrementCounter,  // 2
};

struct Counter
{
	uint64_t counter;
};

uint64_t initialize_counter(SolParameters *params);
uint64_t increment_counter(SolParameters *params);
uint64_t decrement_counter(SolParameters *params);

extern uint64_t entrypoint(
	const uint8_t *input)
{
	SolAccountInfo accounts[1];
	SolParameters params = (SolParameters){.ka = accounts};

	if (!sol_deserialize(input, &params, SOL_ARRAY_SIZE(accounts)))
	{
		sol_log("Failed to deserialize input");
		return ERROR_INVALID_ARGUMENT;
	}

	if (params.data_len == 0)
	{
		sol_log("Invalid data length");
		return ERROR_INVALID_ARGUMENT;
	}

	switch (params.data[0])
	{
	case InitializeCounter:
		sol_log("InitializeCounter");
		return initialize_counter(&params);
	case IncrementCounter:
		sol_log("IncrementCounter");
		return increment_counter(&params);
	case DecrementCounter:
		sol_log("DecrementCounter");
		return decrement_counter(&params);
	default:
		sol_log("Invalid instruction data");
		return ERROR_INVALID_INSTRUCTION_DATA;
	}
}

uint64_t initialize_counter(SolParameters *params)
{
	SolAccountInfo *account = &params->ka[0];

	if (!account->is_writable)
	{
		sol_log("Account is not writable");
		return ERROR_INVALID_ACCOUNT_DATA;
	}

	struct Counter *counter_data = (struct Counter *)account->data;
	counter_data->counter = 0;

	sol_log("Counter initialized to 0");

	return SUCCESS;
}

uint64_t increment_counter(SolParameters *params)
{
	SolAccountInfo *account = &params->ka[0];

	if (!account->is_writable)
	{
		sol_log("Account is not writable");
		return ERROR_INVALID_ACCOUNT_DATA;
	}

	struct Counter *counter_data = (struct Counter *)account->data;
	counter_data->counter += 1;

	sol_log("Counter incremented");

	return SUCCESS;
}

uint64_t decrement_counter(SolParameters *params)
{
	SolAccountInfo *account = &params->ka[0];

	if (!account->is_writable)
	{
		sol_log("Account is not writable");
		return ERROR_INVALID_ACCOUNT_DATA;
	}

	struct Counter *counter_data = (struct Counter *)account->data;

	if (counter_data->counter == 0)
	{
		sol_log("Counter is already 0, cannot decrement");
		return ERROR_INVALID_ARGUMENT;
	}

	counter_data->counter -= 1;

	sol_log("Counter decremented");

	return SUCCESS;
}
