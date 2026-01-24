# Rust SDK

## Overview

Rust SDK for NLS tracker devices.

## Installation

Add to `Cargo.toml`:
```toml
[dependencies]
nls-tracker = "0.1.0"
```

## Usage

```rust
use nls_tracker::Tracker;

let tracker = Tracker::new("192.168.4.1")?;
let data = tracker.get_sensor_data()?;
println!("{:?}", data);
```

---

**Last Updated**: 2025-02-02  
**Version**: 1.0.0
