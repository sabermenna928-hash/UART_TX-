# UART Transmitter

This project implements a UART Transmitter using Verilog

## Modules

- `uart_top.v`  
  Top module that connects all UART transmitter blocks.

- `fsm.v`  
  Controls the UART transmission sequence and states.

- `serializer.v`  
  Converts parallel input data into serial output.

- `parity_calc.v`  
  Calculates the parity bit.

- `mux.v`  
  Selects the correct transmitted bit during UART transmission.

- `top_testbench.v`  
  Testbench used to verify the UART transmitter functionality.

## UART Frame

The transmitted UART frame consists of:

`Start Bit -> Data Bits -> Parity Bit -> Stop Bit`

## Features

- Serial data transmission
- Configurable parity support
- FSM-based control
- Parallel-to-serial conversion
- RTL simulation testbench

## Tools

- Verilog 
- QuestaSim 

## Author

Menna allah mahmoud Saber
