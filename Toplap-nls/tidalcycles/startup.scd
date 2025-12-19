// SuperCollider Startup File for TidalCycles
// Save this as: ~/Library/Application Support/SuperCollider/startup.scd
// This will run automatically when SuperCollider starts

(
s.options.numBuffers = 1024 * 256; // Increase buffer count
s.options.memSize = 8192 * 64;     // Increase memory size
s.options.maxNodes = 1024 * 32;    // Increase node count
s.options.numOutputBusChannels = 2; // Stereo output
s.options.numInputBusChannels = 2;  // Stereo input

s.waitForBoot {
    ~dirt = SuperDirt(2, s); // Two orbits (output channels)
    
    // Load default samples
    ~dirt.loadSoundFiles;
    
    // Optionally load custom samples from specific directory
    // Uncomment and modify path if needed:
    // ~dirt.loadSoundFiles("/path/to/your/samples/*");
    
    // Start SuperDirt on port 57120
    s.sync; // Wait for server to finish booting
    
    ~dirt.start(57120, 0!12); // 12 orbits on port 57120
    
    "SuperDirt ready!".postln;
    
    // Post sample library
    "Available samples:".postln;
    ~dirt.soundLibrary.keys.do { |key| key.postln };
};
);

// SuperCollider will auto-boot and start SuperDirt
// You'll see "SuperDirt ready!" when it's running
