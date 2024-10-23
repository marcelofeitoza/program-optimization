.section .text
.globl entrypoint
.type entrypoint,@function
entrypoint:
    // Save the input pointer (r1) onto the stack
    stxdw [r10 - 16], r1

    // Set up the accounts array on the stack at [r10 - 112]
    mov64 r1, r10
    add64 r1, -112
    // Store the pointer to accounts in params.ka
    stxdw [r10 - 120], r1
    // Zero out params (size 40 bytes)
    mov64 r2, 0
    mov64 r3, 40
    call memset                     // You may need to implement memset in assembly or adjust accordingly

    // Prepare parameters for sol_deserialize
    ldxdw r1, [r10 - 16]            // r1 = input (from stack)
    mov64 r2, r10
    add64 r2, -120                  // r2 = &params
    mov64 r3, 1                     // r3 = ka_num (number of accounts)

    // Call sol_deserialize_wrapper
    call sol_deserialize_wrapper

    // Check the return value of sol_deserialize
    jne r0, 0, deserialization_success
    // If deserialization failed, return error
    mov64 r0, 1                      // ERROR_INVALID_ARGUMENT
    exit

deserialization_success:
    // Load pointer to params
    mov64 r1, r10
    add64 r1, -120

    // Load params.data_len (offset 24 in SolParameters)
    ldxdw r2, [r1 + 24]              // r2 = params.data_len
    jeq r2, 0, exit_with_error       // If data_len == 0, exit with error

    // Load params.data pointer (offset 16)
    ldxdw r3, [r1 + 16]              // r3 = params.data

    // Load instruction byte
    ldxb r4, [r3 + 0]                // r4 = instruction byte

    // Load params.ka_num (offset 8 in SolParameters)
    ldxdw r5, [r1 + 8]               // r5 = params.ka_num
    jeq r5, 0, exit_with_error       // If ka_num == 0, exit with error

    // Load params.ka_ptr (offset 0)
    ldxdw r6, [r1 + 0]               // r6 = params.ka_ptr

    // Load first account's data pointer (params.ka[0].data at offset 16)
    ldxdw r6, [r6 + 0]               // r6 = &params.ka[0]
    ldxdw r6, [r6 + 16]              // r6 = params.ka[0].data

    // Process instruction
    jeq r4, 0x00, init_counter
    jeq r4, 0x01, increment_counter
    jeq r4, 0x02, decrement_counter

    // Invalid instruction
    mov64 r0, 1                       // ERROR_INVALID_INSTRUCTION_DATA
    exit

init_counter:
    // Log entering init_counter
    mov64 r1, 0
    mov64 r2, 0
    mov64 r3, 0
    mov64 r4, 0                       // Instruction ID for init_counter
    mov64 r5, 0
    call 2                            // Call sol_log_64

    // Initialize counter to 0
    mov64 r0, 0
    stxdw [r6 + 0], r0                // *counter = 0
    mov64 r0, 0                       // SUCCESS
    exit

increment_counter:
    // Log entering increment_counter
    mov64 r1, 0
    mov64 r2, 0
    mov64 r3, 0
    mov64 r4, 0
    mov64 r5, 1                       // Instruction ID for increment_counter
    call 2                            // Call sol_log_64

    // Load current counter value
    ldxdw r7, [r6 + 0]                // r7 = *counter
    add64 r7, 1                       // r7 += 1
    stxdw [r6 + 0], r7                // *counter = r7
    mov64 r0, 0                       // SUCCESS
    exit

decrement_counter:
    // Log entering decrement_counter
    mov64 r1, 0
    mov64 r2, 0
    mov64 r3, 0
    mov64 r4, 0
    mov64 r5, 2                       // Instruction ID for decrement_counter
    call 2                            // Call sol_log_64

    // Load current counter value
    ldxdw r7, [r6 + 0]                // r7 = *counter
    jeq r7, 0, underflow_error        // If counter == 0, error
    sub64 r7, 1                       // r7 -= 1
    stxdw [r6 + 0], r7                // *counter = r7
    mov64 r0, 0                       // SUCCESS
    exit

underflow_error:
    mov64 r0, 2                       // ERROR_CUSTOM_ZERO
    exit

exit_with_error:
    mov64 r0, 1                       // ERROR_INVALID_ARGUMENT
    exit
