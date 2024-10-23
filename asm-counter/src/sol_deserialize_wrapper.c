// src/sol_deserialize_wrapper.c
#include <solana_sdk.h>

bool sol_deserialize_wrapper(const uint8_t *input, SolParameters *params, uint64_t ka_num)
{
    return sol_deserialize(input, params, ka_num);
}
