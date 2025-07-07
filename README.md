# Traffic Light Controller (VHDL)

## Overview

This project implements a traffic light controller for a T-junction intersection using VHDL, designed and simulated in **Xilinx Vivado**. The system operates as a finite state machine (FSM) to manage light transitions safely and realistically, with timing designed to resemble real-life operation.

## Features

- Supports **two directions**: North (main road) and East-West (secondary road).
- **Eight well-defined states** with realistic timing (seconds rather than nanoseconds).
- Uses **D flip-flop logic** for state transitions.
- Reset functionality to force all lights to red for safety.
- Behavioral VHDL design with testbench verification.

## FSM Design

### States and Timing

| State         | North Light (R,Y,G) | East-West Light (R,Y,G) | Time (s) |
|---------------|---------------------|--------------------------|----------|
| AllRed        | 100                 | 100                      | 2        |
| NorthWait     | 110                 | 100                      | 2        |
| NorthGo       | 001                 | 100                      | 30       |
| EndNorth      | 010                 | 100                      | 2        |
| AllRedAgain   | 100                 | 100                      | 2        |
| EastWestWait  | 100                 | 110                      | 2        |
| EastWestGo    | 100                 | 001                      | 30       |
| EndEastWest   | 100                 | 010                      | 2        |

### State Encoding (Q)

- States encoded using 3-bit vectors for flip-flops.
- Example codes: `AllRed = 000`, `NorthWait = 001`, ..., `EndEastWest = 111`.
- "Don’t care" states are handled safely to prevent undefined behavior.

### Light Encodings

- Red: `100`
- Red-Yellow: `110`
- Green: `001`
- Yellow: `010`
- Off: `000`

## VHDL Design

- **Entity Ports**:
  - `Clk`: System clock for synchronous operation.
  - `negReset`: Active-low reset to force all lights to red.
  - `NorthLight`, `EastWestLight`: 3-bit vectors representing each direction's light state.

- **Architecture**:
  - States and counters defined internally.
  - Uses process and case statements to manage state transitions and timing.
  - Constants for clock frequency and period allow easy adaptation.

## Testbench

- Provides complete stimulus for simulation.
- Generates clock signal and controls `negReset`.
- Observes light outputs for both directions.
- Simulated with realistic time scaling (1 second = 10 clock cycles) for clear, human-readable behavior.

## Simulation Results

- Correct sequence through all states.
- Lights transition smoothly with correct timings.
- Reset functionality verified: when active, both lights forced to red.

## How to Run

1. Clone the repository:

   ```bash
   git clone https://github.com/your-username/traffic-light-controller.git
   cd traffic-light-controller

2. Open Xilinx Vivado.

3. Create a new project and add traffic_light_system.vhd and traffic_light_system_tb.vhd.

4. Set traffic_light_system_tb as the top module.

5. Run behavioral simulation and inspect waveforms.
