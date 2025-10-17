# Contributing to Apache Spark Dev Container

First off, thank you for considering contributing to this project! 🎉

It's people like you that make this project such a great tool for the community. This document provides guidelines for contributing to the project.

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
  - [Reporting Bugs](#reporting-bugs)
  - [Suggesting Enhancements](#suggesting-enhancements)
  - [Your First Code Contribution](#your-first-code-contribution)
  - [Pull Requests](#pull-requests)
- [Development Setup](#development-setup)
- [Style Guidelines](#style-guidelines)
  - [Dockerfile Guidelines](#dockerfile-guidelines)
  - [Documentation Guidelines](#documentation-guidelines)
  - [Commit Messages](#commit-messages)
- [Testing](#testing)
- [Community](#community)

---

## Code of Conduct

This project and everyone participating in it is governed by our commitment to fostering an open and welcoming environment. By participating, you are expected to uphold this code.

### Our Standards

**Examples of behavior that contributes to a positive environment:**

- Using welcoming and inclusive language
- Being respectful of differing viewpoints and experiences
- Gracefully accepting constructive criticism
- Focusing on what is best for the community
- Showing empathy towards other community members

**Examples of unacceptable behavior:**

- Trolling, insulting/derogatory comments, and personal or political attacks
- Public or private harassment
- Publishing others' private information without explicit permission
- Other conduct which could reasonably be considered inappropriate in a professional setting

---

## How Can I Contribute?

### Reporting Bugs

This section guides you through submitting a bug report. Following these guidelines helps maintainers understand your report and reproduce the issue.

**Before Submitting A Bug Report:**

- Check the [documentation](README.md) for common issues
- Check [existing issues](https://github.com/yourusername/vscode_dev_docker/issues) to avoid duplicates
- Collect information about the bug:
  - Docker version (`docker --version`)
  - Host OS and version
  - Steps to reproduce
  - Expected vs actual behavior

**How to Submit A Good Bug Report:**

Create an issue with the following information:

```markdown
**Description:**
A clear and concise description of the bug.

**To Reproduce:**
Steps to reproduce the behavior:
1. Build the image with '...'
2. Run container with '...'
3. Execute command '...'
4. See error

**Expected Behavior:**
What you expected to happen.

**Actual Behavior:**
What actually happened.

**Environment:**
- OS: [e.g., macOS 13.0, Ubuntu 22.04]
- Docker version: [e.g., 24.0.5]
- Container runtime: [e.g., Docker Desktop, containerd]

**Logs:**

```text
Paste relevant logs here
```

**Additional Context:**
Any other context about the problem.

### Suggesting Enhancements

This section guides you through submitting an enhancement suggestion, including completely new features and minor improvements.

**Before Submitting An Enhancement:**

- Check if the enhancement has already been suggested
- Check if the enhancement aligns with the project's goals
- Consider if the enhancement would be useful to the majority of users

**How to Submit A Good Enhancement Suggestion:**

Create an issue with:

- **Clear and descriptive title**
- **Detailed description** of the proposed feature
- **Use cases** - explain why this would be useful
- **Possible implementation** - if you have ideas
- **Alternatives considered** - other approaches you've thought about

### Your First Code Contribution

Unsure where to begin? You can start by looking for issues labeled:

- `good first issue` - issues which should only require a few lines of code
- `help wanted` - issues which should be more involved

### Pull Requests

The process described here has several goals:

- Maintain code quality
- Fix problems that are important to users
- Engage the community in working toward the best possible product
- Enable a sustainable system for maintainers to review contributions

**Pull Request Process:**

1. **Fork the repository** and create your branch from `master`:

   ```bash
   git checkout -b feature/amazing-feature
   ```

1. **Make your changes:**

   - Follow the [style guidelines](#style-guidelines)
   - Update documentation as needed
   - Add or update tests if applicable

1. **Test your changes:**

   ```bash
   # Build the Docker image
   docker build -t spark-dev:test .
   
   # Test the container
   docker run -it spark-dev:test bash
   
   # Run validation tests
   ./scripts/validate.sh  # if available
   ```

1. **Commit your changes:**

   ```bash
   git commit -m "feat: add amazing feature"
   ```

1. **Push to your fork:**

   ```bash
   git push origin feature/amazing-feature
   ```

1. **Open a Pull Request:**

   - Use a clear and descriptive title
   - Reference any related issues
   - Describe your changes in detail
   - Include screenshots for UI changes

**Pull Request Checklist:**

- [ ] Code follows the project's style guidelines
- [ ] Documentation has been updated
- [ ] Changes have been tested locally
- [ ] Commit messages follow the guidelines
- [ ] No merge conflicts
- [ ] PR description is clear and complete

---

## Development Setup

### Prerequisites

- Docker Desktop or Docker Engine
- Git
- Visual Studio Code (optional but recommended)
- Basic knowledge of Docker and Dockerfile syntax

### Setting Up Development Environment

1. **Clone your fork:**

   ```bash
   git clone https://github.com/YOUR-USERNAME/vscode_dev_docker.git
   cd vscode_dev_docker
   ```

2. **Add upstream remote:**

   ```bash
   git remote add upstream https://github.com/ORIGINAL-OWNER/vscode_dev_docker.git
   ```

3. **Create a development branch:**

   ```bash
   git checkout -b feature/your-feature-name
   ```

4. **Make your changes** and test locally

5. **Keep your fork synced:**

   ```bash
   git fetch upstream
   git merge upstream/master
   ```

### Testing Changes

**Build and test the Docker image:**

```bash
# Build with custom tag
docker build -t spark-dev:dev .

# Test basic functionality
docker run -it spark-dev:dev bash -c "
  spark-submit --version &&
  java -version &&
  scala -version &&
  python3 --version
"

# Test with VS Code (if using devcontainer)
code .
# Then use: Remote-Containers: Reopen in Container
```

**Validate the Dockerfile:**

```bash
# Use hadolint for Dockerfile linting
docker run --rm -i hadolint/hadolint < Dockerfile

# Security scan
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock \
  aquasec/trivy image spark-dev:dev
```

---

## Style Guidelines

### Dockerfile Guidelines

- **Use official base images**: Prefer official images (e.g., `ubuntu:22.04`)
- **Pin versions**: Always specify exact versions for reproducibility
- **Minimize layers**: Combine RUN commands where logical
- **Clean up**: Remove temporary files and caches in the same layer
- **Security first**: Run as non-root user when possible
- **Label everything**: Use LABELs for metadata
- **Order matters**: Put frequently changing commands last for better caching

**Example:**

```dockerfile
# Good
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        package1 \
        package2 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Bad
RUN apt-get update
RUN apt-get install -y package1
RUN apt-get install -y package2
RUN apt-get clean
```

### Documentation Guidelines

- **Use clear language**: Write for all skill levels
- **Include examples**: Show don't just tell
- **Keep it updated**: Update docs with code changes
- **Use proper markdown**: Follow markdown best practices
- **Link related sections**: Help users navigate

### Commit Messages

Follow the [Conventional Commits](https://www.conventionalcommits.org/) specification:

**Format:**

```text
<type>(<scope>): <subject>

<body>

<footer>
```

**Types:**

- `feat`: A new feature
- `fix`: A bug fix
- `docs`: Documentation only changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring
- `perf`: Performance improvements
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

**Examples:**

```bash
feat(docker): add Python 3.11 support

Add Python 3.11 as an option with build args
Maintain backward compatibility with 3.10

Closes #123

---

fix(dockerfile): resolve permission issue for sparkuser

Change ownership of /opt/spark to sparkuser to fix
permission denied errors when running Spark jobs

Fixes #456

---

docs(readme): update installation instructions

Add more detailed steps for Windows users
Include troubleshooting section for common errors
```

---

## Testing

### Manual Testing Checklist

Before submitting a PR, ensure:

- [ ] Image builds successfully without errors
- [ ] Container starts and bash prompt is accessible
- [ ] Java, Scala, Python, and Spark are installed correctly
- [ ] Spark shell launches successfully (`spark-shell`)
- [ ] PySpark launches successfully (`pyspark`)
- [ ] Can submit a simple Spark job
- [ ] Non-root user works correctly
- [ ] All documented features work as described
- [ ] No new security vulnerabilities introduced

### Automated Testing

If CI/CD is set up:

```yaml
# Example GitHub Actions workflow
name: CI

on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Build Docker image
        run: docker build -t spark-dev:test .
      - name: Test Spark installation
        run: docker run spark-dev:test spark-submit --version
```

---

## Community

### Getting Help

- 📖 Read the [README](README.md)
- 🐛 Search [existing issues](https://github.com/yourusername/vscode_dev_docker/issues)
- 💬 Join [discussions](https://github.com/yourusername/vscode_dev_docker/discussions)
- 📧 Contact maintainers (see README)

### Recognition

Contributors will be recognized in:

- GitHub contributors page
- Release notes (for significant contributions)
- README acknowledgments section

---

## Questions?

Don't hesitate to ask questions! We're here to help:

- Open an issue with the `question` label
- Start a discussion on GitHub Discussions
- Reach out to maintainers

---

## Thank you for contributing! 🚀

Your efforts help make this project better for everyone in the community.
