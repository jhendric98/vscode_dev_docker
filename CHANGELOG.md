# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed

- Updated Apache Spark from 3.5.1 to 4.0.1 (major version upgrade)
- Updated PySpark to 4.0.1
- Updated build configurations (SBT, Maven) to Spark 4.0.1
- Added Spark 4.0 compatibility notes to documentation

### Planned

- Automated CI/CD pipeline with GitHub Actions
- Multi-architecture builds (AMD64 and ARM64)
- Cloud environment profiles (AWS, Azure, GCP)
- Pre-built Docker Hub images

---

## [1.0.0] - 2025-10-17

### Added

- Initial release of Apache Spark Dev Container for VS Code
- Ubuntu 22.04 LTS as base image
- Apache Spark 3.5.1 with Hadoop 3 (now updated to 4.0.1)
- Java OpenJDK 11
- Scala 2.13 support
- Python 3.10+ with pip
- SBT (Scala Build Tool)
- Maven build tool
- VS Code Remote Containers configuration
- Complete development environment setup
- Security-hardened Dockerfile with non-root user
- Health check for container monitoring
- Comprehensive documentation
  - README.md with full usage guide
  - CONTRIBUTING.md with contribution guidelines
  - SECURITY.md with security policy
  - LICENSE (MIT)
- Git and bash completion utilities
- Docker metadata labels
- Environment variables pre-configured
- Multi-port exposure for Spark UIs
- .gitignore for common development files

### Security

- Non-root user execution (sparkuser:1000)
- Minimal package installation
- Regular security updates via base image
- No hardcoded credentials
- Secure package repository verification
- Read-only root filesystem compatible

### Documentation

- GitHub-compliant README with badges
- Table of contents and navigation
- Quick start guide
- Comprehensive troubleshooting section
- Configuration and customization examples
- Contributing guidelines
- Security policy and vulnerability reporting
- MIT License

### Changed

- N/A (Initial release)

### Deprecated

- N/A (Initial release)

### Removed

- N/A (Initial release)

### Fixed

- N/A (Initial release)

---

## Release Notes

### Version 1.0.0 Highlights

This is the inaugural release of the Apache Spark Development Container, providing a complete, production-ready environment for Spark development with Visual Studio Code.

**Key Features:**

- 🚀 One-click setup with VS Code Remote Containers
- 🔒 Security-first approach with non-root execution
- 📦 Everything included: Spark, Scala, Java, Python, Maven, SBT
- 🛠️ Fully customizable and extensible
- 📚 Comprehensive documentation and examples

**What's Included:**

- Apache Spark 4.0.1 with Hadoop 3 distribution
- Complete Scala development environment (2.13)
- Python 3 with PySpark support
- Java 11 runtime environment
- Build tools (SBT, Maven)
- Development utilities (Git, vim, curl, wget)
- VS Code extensions for enhanced productivity

**Use Cases:**

- Local Spark application development
- Data engineering projects
- Educational purposes and learning Spark
- Team collaboration with reproducible environments
- CI/CD testing pipelines

**Getting Started:**

```bash
git clone https://github.com/yourusername/vscode_dev_docker.git
cd vscode_dev_docker
code .
# Click "Reopen in Container"
# Note: Now using Spark 4.0.1 with breaking changes from 3.x
```

**System Requirements:**

- Docker Desktop or Docker Engine
- Visual Studio Code with Remote Containers extension
- 8GB RAM minimum (16GB recommended)
- 10GB disk space

---

## Versioning Strategy

This project uses [Semantic Versioning](https://semver.org/):

- **MAJOR** version: Incompatible changes (e.g., removing features, breaking configuration)
- **MINOR** version: New features added in a backwards compatible manner
- **PATCH** version: Backwards compatible bug fixes and minor improvements

### Version Numbers

- Format: `MAJOR.MINOR.PATCH` (e.g., 1.2.3)
- Pre-release: `MAJOR.MINOR.PATCH-alpha.1` or `-beta.1` or `-rc.1`

---

## How to Update

To update to the latest version:

```bash
# Pull latest changes
git pull origin master

# Rebuild the container
docker build --no-cache -t spark-dev:latest .

# Or in VS Code: Rebuild Container
# Command Palette → "Remote-Containers: Rebuild Container"
```

---

## Upgrade Notes

### Upgrading to 1.0.0

- First release, no upgrade path needed
- Fresh installation recommended

---

## Support

For questions or issues with a specific release:

- Check the [documentation](README.md)
- Search [existing issues](https://github.com/yourusername/vscode_dev_docker/issues)
- Open a [new issue](https://github.com/yourusername/vscode_dev_docker/issues/new)

---

## Links

- [Repository](https://github.com/yourusername/vscode_dev_docker)
- [Issue Tracker](https://github.com/yourusername/vscode_dev_docker/issues)
- [Releases](https://github.com/yourusername/vscode_dev_docker/releases)
- [Contributing Guide](CONTRIBUTING.md)
- [Security Policy](SECURITY.md)

---

**Legend:**

- `Added` for new features
- `Changed` for changes in existing functionality
- `Deprecated` for soon-to-be removed features
- `Removed` for now removed features
- `Fixed` for any bug fixes
- `Security` for vulnerability fixes and security improvements
