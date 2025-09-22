
# UART Packetizer with FSM and FIFO Integration

This project implements a **UART Packetizer** in Verilog that accepts 8-bit parallel data, buffers it using a FIFO, organizes packets via an FSM, and serializes them with a UART transmitter. The design is modular, reusable, and verified using Vivado.

---

## 📌 Features

* 8-bit data width, parameterizable baud rate (e.g., 9600, 115200).
* FIFO buffer (depth = 16) with `fifo_full`, `fifo_empty`, and `data_out_valid`.
* Packetizer FSM with handshake (`tx_ready`) and packet framing logic.
* UART TX with 1 start bit, 8 data bits, 1 stop bit, no parity.
* Verified using **Vivado simulation and reports**.

---

## 📂 Repository Structure

```
.
├── RTL/                # RTL modules (fifo, packetizer_fsm, uart_tx, top_packetizer)
├── Test_bench/         # Testbenches for functional simulation
├── Reports/            # Synthesis and timing reports from Vivado
├── Outputs/            # Simulation waveform screenshots
└── README.md
```

---

## 🏗️ Top Module

```verilog
module top_packetizer (
    input clk, rst,
    input [7:0] data_in,
    input data_valid,
    output serial_out,
    output tx_busy
);
```

Instantiates:

* **fifo** – Data buffering
* **packetizer\_fsm** – Controls packet flow
* **uart\_tx** – Serial transmission

---

## 🔄 State Diagram

### 📷 FSM Diagram

<img width="337" height="692" alt="state_diagram" src="https://github.com/user-attachments/assets/bdf547cc-fb34-4d47-8699-17163d2c76c6" />


---

## ▶️ How to Run (Vivado)

1. Open **Vivado**.
2. Create a new **project** and add:

   * `rtl/` files as design sources.
   * `testbench/` files as simulation sources.
3. Run **Behavioral Simulation** to view waveforms.
4. Run **Synthesis** and **Implementation** to generate reports.

---

## 📊 Results

* Verified transmission of multiple packets with correct framing.
* Waveforms show `serial_out`, `fifo_full`, `tx_busy`, and FSM states.
* Vivado reports cover utilization, timing, and FSM encoding.

---

## 📎 Author

**Vishwa Patwari**

* [GitHub](https://github.com/vishwa-patwari)
* [LinkedIn](https://linkedin.com/in/kpvishwa)

---
