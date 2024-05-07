# All-Digital PLL
This is the final project of the course "Advanced Digital Integrated Circuits Design" at CCU CS

### Structure
    .
    ├── doc/
    │   └── adpll_report_ch.pdf          # Final Report of this Project Written in Chinese.
    │
    ├── src/
    │   ├── SPICE/                       # SPICE Netlist
    │   │   ├── DCO.sp                   # Digitally-Controlled Ocsillator
    │   │   └── PFD.sp                   # Phase Frequency Detector
    │   │
    │   └── VERILOG/                     # Verilog RTL Code
    │       ├── CONTROLLER.v             # Controller
    │       ├── DCO.v                    # Digitally-Controlled Oscillator
    │       ├── DIV.v                    # Divider
    │       ├── PFD.v                    # Phase Frequency Detector
    │       ├── TEST.v                   # Test module
    │       └── TOP.v                    # Top module
    │
    └── README.md

### Output Waveform ( Reference Clock = 400MHz, Divisor = 7) 
![Screenshot 2024-05-08 000953](https://github.com/hsu26zq/game/assets/95536686/bac4c97c-5a88-4496-a7f9-e0c2931c96c3)


