# C++ SDK

## Overview

C++ SDK for NLS tracker devices.

## Installation

```bash
git clone https://github.com/nonlineari/nls-tracker-cpp-sdk.git
cd nls-tracker-cpp-sdk
mkdir build && cd build
cmake ..
make
sudo make install
```

## Usage

```cpp
#include <nls_tracker/tracker.h>

nls::Tracker tracker("192.168.4.1");
auto data = tracker.getSensorData();
std::cout << data << std::endl;
```

---

**Last Updated**: 2025-02-02  
**Version**: 1.0.0
