# All-Digital PLL
### Structure
    .
    ├── doc/
    │   └── report.ppt                   # Final Report of this Project Written in Chinese.
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
