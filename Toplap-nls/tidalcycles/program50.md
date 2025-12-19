Python virtual environments have some limitations:

Isolation limitations:
•  Only isolates Python packages, not system libraries (C/C++ dependencies, system tools, etc.)
•  Uses the same Python interpreter version that created it - can't switch Python versions within a venv
•  Doesn't isolate environment variables or system PATH (except for Python-specific ones)

Portability:
•  Not portable between machines - absolute paths are hardcoded in activation scripts
•  Not portable between operating systems
•  Can't simply copy/move a venv to a different location without recreating it

Performance:
•  No performance overhead - packages run at native speed
•  Disk space: each venv duplicates packages (no sharing between venvs)

Functionality:
•  Can't install packages that require system-level permissions
•  System packages installed with brew or apt aren't automatically available unless you use --system-site-packages flag
•  Some packages with complex binary dependencies may still need system libraries installed separately

Management:
•  Need to activate/deactivate manually for each shell session
•  Can accidentally install to wrong environment if you forget to activate
•  Multiple venvs for different projects = more disk space used

For your opencv-python installation, the main limitation is that opencv's underlying system libraries (like video codecs) depend on what's available on your macOS system. The venv only isolates the Python bindings.
