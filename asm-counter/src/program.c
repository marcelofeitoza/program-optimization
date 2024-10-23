#include <solana_sdk.h>

uint64_t entrypoint(const uint8_t *input)
{
    SolAccountInfo accounts[1];
    SolParameters params = {.ka = accounts};

    if (!sol_deserialize(input, &params, SOL_ARRAY_SIZE(accounts)))
    {
        return ERROR_INVALID_ARGUMENT;
    }

    // Use the deserialized data
    sol_log("Deserialization successful");

    // Access params.data_len and log it
    sol_log_64(0, 0, 0, 0, params.data_len);

    // Further logic can be added here

    return SUCCESS;
}
