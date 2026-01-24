# Contributing to NLS Tracker Device

Thank you for your interest in contributing to the NLS Artist Systems tracker device project! This document provides guidelines and instructions for contributing.

## Code of Conduct

By participating in this project, you agree to abide by our [Code of Conduct](./CODE_OF_CONDUCT.md).

## How to Contribute

### Reporting Bugs

#### Before Submitting a Bug Report
- Check if the bug has already been reported in [Issues](https://github.com/nonlineari/toplap-nls/issues)
- Verify you're using the latest version
- Try to reproduce the issue

#### Submitting a Bug Report
1. Use the bug report template
2. Provide a clear, descriptive title
3. Include:
   - Steps to reproduce
   - Expected behavior
   - Actual behavior
   - Environment (hardware version, firmware version, OS)
   - Screenshots/logs if applicable

### Suggesting Enhancements

#### Before Submitting an Enhancement
- Check if the enhancement has been suggested
- Consider if it aligns with project goals
- Think about implementation complexity

#### Submitting an Enhancement
1. Use the enhancement template
2. Provide:
   - Clear description
   - Use case and motivation
   - Proposed solution
   - Alternatives considered

### Contributing Code

#### Development Workflow
1. **Fork** the repository
2. **Clone** your fork
3. **Create** a feature branch (`git checkout -b feature/amazing-feature`)
4. **Make** your changes
5. **Test** your changes thoroughly
6. **Commit** your changes (`git commit -m 'Add amazing feature'`)
7. **Push** to your branch (`git push origin feature/amazing-feature`)
8. **Open** a Pull Request

#### Coding Standards

##### C/C++ (Firmware)
- Follow [ESP-IDF Style Guide](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/contribute/style-guide.html)
- Use 4 spaces for indentation
- Maximum line length: 100 characters
- Use meaningful variable and function names
- Add comments for complex logic

##### Python
- Follow [PEP 8](https://www.python.org/dev/peps/pep-0008/)
- Use 4 spaces for indentation
- Maximum line length: 100 characters
- Type hints encouraged

##### JavaScript
- Follow [Airbnb JavaScript Style Guide](https://github.com/airbnb/javascript)
- Use 2 spaces for indentation
- Use ES6+ features
- Add JSDoc comments

##### Markdown (Documentation)
- Follow the [Documentation Standards](../KNOWLEDGE_BASE_STRUCTURE.md#documentation-standards)
- Use proper heading hierarchy
- Include code examples
- Add cross-references

#### Commit Messages
- Format: `[section] Brief description`
- Examples:
  - `[firmware] Add IMU calibration`
  - `[hardware] Update BOM for v2.0`
  - `[docs] Fix installation steps`
  - `[fix] Resolve WiFi connection issue`

#### Pull Request Process
1. Update documentation if needed
2. Add tests if applicable
3. Ensure all tests pass
4. Update CHANGELOG.md
5. Request review from maintainers
6. Address review comments
7. Wait for approval before merging

### Contributing Documentation

#### Documentation Types
- **Hardware Documentation**: Specifications, assembly guides, schematics
- **Software Documentation**: API references, tutorials, examples
- **Integration Guides**: NLS systems, external tools
- **Troubleshooting**: Common issues and solutions

#### Documentation Standards
- Use clear, concise language
- Include code examples
- Add diagrams where helpful
- Cross-reference related documentation
- Keep documentation up-to-date

### Contributing Hardware

#### Hardware Contributions
- **Schematics**: KiCad or Eagle format
- **PCB Layouts**: Gerber files and drill files
- **3D Models**: STEP or STL files
- **Enclosure Designs**: STL files for 3D printing

#### Hardware Standards
- Follow open hardware principles
- Use standard components where possible
- Document all design decisions
- Include BOM and assembly instructions

## Development Setup

### Hardware Setup
See [Hardware Setup Guide](./04-development/getting-started/hardware-setup.md)

### Software Setup
See [Software Setup Guide](./04-development/getting-started/software-setup.md)

### Development Environment
See [Development Environment Guide](./04-development/getting-started/development-environment.md)

## Testing

### Hardware Testing
- Follow [Testing Procedures](./01-hardware/assembly/testing-procedures.md)
- Test on multiple hardware versions if possible
- Document test results

### Software Testing
- Write unit tests for new features
- Run integration tests
- Test on different platforms if applicable

## Review Process

### Code Review
- All code must be reviewed before merging
- Reviews focus on:
  - Code quality and style
  - Functionality and correctness
  - Performance implications
  - Documentation completeness

### Documentation Review
- Documentation is reviewed for:
  - Accuracy and clarity
  - Completeness
  - Consistency with style guide
  - Proper cross-references

## Recognition

Contributors will be:
- Listed in CONTRIBUTORS.md
- Credited in release notes
- Acknowledged in documentation

## Questions?

- **GitHub Issues**: For bug reports and feature requests
- **Discussions**: For questions and general discussion
- **Email**: Contact maintainers directly

## License

By contributing, you agree that your contributions will be licensed under the same license as the project.

---

**Thank you for contributing!**
