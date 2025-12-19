// SuperDirt Installation Script for SuperCollider
// Run this in SuperCollider to install SuperDirt and dependencies

// Step 1: Update Quarks (package manager)
Quarks.checkForUpdates({
    
    // Step 2: Install SuperDirt
    Quarks.install("SuperDirt", "v1.7.3");
    
    // Step 3: Install SC3 Plugins (additional synthesis plugins)
    Quarks.install("SC3plugins");
    
    // Step 4: Recompile the class library
    thisProcess.recompile();
    
    "SuperDirt installation complete! Please restart SuperCollider.".postln;
});

// After restart, test SuperDirt with this:
// SuperDirt.start
