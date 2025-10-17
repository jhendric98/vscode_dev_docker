# Apache Spark Dev Container for VS Code

[![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/)
[![Apache Spark](https://img.shields.io/badge/Apache%20Spark-4.0.1-E25A1C?style=for-the-badge&logo=apache-spark&logoColor=white)](https://spark.apache.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)

A production-ready, hardened Docker development container for Apache Spark with Visual Studio Code Remote Containers support. Get started with Spark development in seconds with a fully configured, reproducible environment.

---

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Quick Start](#quick-start)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
  - [Basic Setup](#basic-setup)
  - [Running Spark](#running-spark)
  - [Development Workflow](#development-workflow)
- [Configuration](#configuration)
- [Customization](#customization)
- [What's Included](#whats-included)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [Security](#security)
- [License](#license)
- [Acknowledgments](#acknowledgments)

---

## 🎯 Overview

This repository provides a containerized Apache Spark development environment optimized for Visual Studio Code's Remote Containers feature. It eliminates the "works on my machine" problem by providing a consistent, isolated development environment with all necessary tools pre-installed and configured.

**Perfect for:**

- Spark application development
- Data engineering projects
- Learning Spark and Scala
- Team collaboration with consistent environments
- CI/CD pipeline testing

---

## ✨ Features

- 🚀 **Quick Setup** - Start developing in minutes, not hours
- 🔒 **Security Hardened** - Non-root user, minimal attack surface
- 📦 **Complete Toolchain** - Spark, Scala, Java, Python, Maven, SBT
- 🔄 **Reproducible** - Same environment across all machines
- ⚡ **Optimized** - Multi-stage build with layer caching
- 🛠️ **Customizable** - Easy to extend and modify
- 📚 **Well Documented** - Comprehensive guides and examples

---

## 🚀 Quick Start

```bash
# Clone the repository
git clone https://github.com/yourusername/vscode_dev_docker.git
cd vscode_dev_docker

# Open in VS Code
code .

# When prompted, click "Reopen in Container"
# Wait for the container to build (first time only)

# Start coding!
```

Once the container is running:

```bash
# Test Spark installation
spark-shell --version

# Run a simple Spark job
spark-submit --version

# Note: Spark 4.0+ includes breaking changes from 3.x
# Review migration guide if upgrading existing applications
```

---

## 📦 Prerequisites

Before you begin, ensure you have the following installed:

- **Visual Studio Code** (1.60 or later)
  - Download: <https://code.visualstudio.com/>
- **Docker Desktop** (or Docker Engine + Docker Compose)
  - Download: <https://www.docker.com/products/docker-desktop>
- **VS Code Remote - Containers Extension**
  - Install from: <https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers>

**System Requirements:**

- **OS**: Windows 10/11, macOS, or Linux
- **RAM**: 8GB minimum (16GB recommended)
- **Disk Space**: 10GB free space

---

## 📥 Installation

### Option 1: Using VS Code Dev Containers (Recommended)

1. **Clone this repository:**

   ```bash
   git clone https://github.com/yourusername/vscode_dev_docker.git
   cd vscode_dev_docker
   ```

2. **Open in VS Code:**

   ```bash
   code .
   ```

3. **Reopen in Container:**
   - VS Code will detect the `.devcontainer` configuration
   - Click "Reopen in Container" when prompted
   - Or use Command Palette (`Ctrl+Shift+P` / `Cmd+Shift+P`) → "Remote-Containers: Reopen in Container"

4. **Wait for build:**
   - First build takes 5-10 minutes
   - Subsequent starts are instant

### Option 2: Manual Docker Build

```bash
# Build the image
docker build -t spark-dev:latest .

# Run the container
docker run -it -v $(pwd):/workspace spark-dev:latest

# Or with port mappings for Spark UI
docker run -it \
  -v $(pwd):/workspace \
  -p 4040:4040 \
  -p 8080:8080 \
  -p 7077:7077 \
  spark-dev:latest
```

---

## 💻 Usage

### Basic Setup

After opening the project in the container:

```bash
# Verify installations
java -version        # OpenJDK 11
scala -version       # Scala 2.13
python3 --version    # Python 3
spark-shell --version # Spark 4.0.1
```

### Running Spark

#### Interactive Shell

```bash
# Scala Shell
spark-shell

# Python Shell (PySpark)
pyspark

# SQL Shell
spark-sql
```

#### Standalone Cluster

```bash
# Start Spark Master
start-master.sh

# Start Spark Worker (in another terminal)
start-worker.sh spark://localhost:7077

# Access Spark Master UI
# http://localhost:8080
```

#### Submit Applications

```bash
# Scala/Java application
spark-submit \
  --class com.example.MainClass \
  --master local[*] \
  target/myapp.jar

# Python application
spark-submit \
  --master local[*] \
  scripts/my_script.py
```

### Development Workflow

1. **Create your Spark project:**

   ```bash
   sbt new scala/scala-seed.g8
   # or
   mvn archetype:generate -DgroupId=com.example -DartifactId=spark-app
   ```

2. **Write your code** in VS Code with IntelliSense support

3. **Build your project:**

   ```bash
   # SBT
   sbt compile
   sbt package

   # Maven
   mvn clean package
   ```

4. **Test and iterate** with immediate feedback

---

## ⚙️ Configuration

### Build Arguments

Customize the Docker image during build:

```bash
docker build \
  --build-arg SPARK_VERSION=4.0.1 \
  --build-arg HADOOP_VERSION=3 \
  --build-arg SCALA_VERSION=2.13 \
  -t spark-dev:custom .
```

| Argument | Default | Description |
|----------|---------|-------------|
| `SPARK_VERSION` | 4.0.1 | Apache Spark version |
| `HADOOP_VERSION` | 3 | Hadoop distribution version |
| `SCALA_VERSION` | 2.13 | Scala version (via Ubuntu) |

### Environment Variables

The following environment variables are pre-configured:

```bash
SPARK_HOME=/opt/spark
JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
PATH=$SPARK_HOME/bin:$SPARK_HOME/sbin:$PATH
```

### VS Code Extensions

The `.devcontainer/devcontainer.json` includes recommended extensions:

- Scala (Metals)
- Python
- Docker
- GitLens

---

## 🎨 Customization

### Adding Additional Tools

Edit the `Dockerfile` to add more packages:

```dockerfile
RUN apt-get update && apt-get install -y \
    postgresql-client \
    redis-tools \
    vim \
    && rm -rf /var/lib/apt/lists/*
```

### Python Dependencies

Create a `requirements.txt`:

```txt
numpy>=1.21.0
pandas>=1.3.0
pyspark==4.0.1
```

Update `Dockerfile`:

```dockerfile
COPY requirements.txt /tmp/
RUN pip3 install --no-cache-dir -r /tmp/requirements.txt
```

### Reducing Image Size

Remove unused components:

```dockerfile
# Remove Maven if using only SBT
RUN apt-get remove -y maven
```

---

## 📦 What's Included

| Component | Version | Purpose |
|-----------|---------|---------|
| **Base OS** | Ubuntu 22.04 LTS | Stable, long-term support |
| **Java** | OpenJDK 11 | Spark runtime (Java 21 compatible) |
| **Apache Spark** | 4.0.1 | Big data processing |
| **Hadoop** | 3.x | Distributed storage |
| **Scala** | 2.13 | Spark application development |
| **Python** | 3.10+ | PySpark development |
| **SBT** | Latest | Scala build tool |
| **Maven** | Latest | Java build tool |
| **Git** | Latest | Version control |
| **curl/wget** | Latest | Download utilities |

---

## 🔧 Troubleshooting

### Container Build Fails

**Problem:** Network timeout during Spark download

```bash
Error: Failed to download spark-4.0.1-bin-hadoop3.tgz
```

**Solution:** Try building with a mirror or retry:

```bash
docker build --no-cache -t spark-dev:latest .
```

### Spark Out of Memory

**Problem:** `java.lang.OutOfMemoryError: Java heap space`

**Solution:** Increase Docker memory allocation:

- Docker Desktop → Settings → Resources → Memory (increase to 8GB+)

**Or configure Spark memory:**

```bash
spark-submit --driver-memory 4g --executor-memory 4g yourapp.jar
```

### Permission Denied in Container

**Problem:** Cannot write files in `/workspace`

**Solution:** The container runs as non-root user `sparkuser`. Ensure your host files have appropriate permissions:

```bash
chmod -R 755 .
```

### VS Code Extension Issues

**Problem:** Metals or other extensions not working

**Solution:**

1. Reload window: `Ctrl+Shift+P` → "Developer: Reload Window"
2. Rebuild container: `Ctrl+Shift+P` → "Remote-Containers: Rebuild Container"
3. Check `.devcontainer/devcontainer.json` configuration

### Port Already in Use

**Problem:** `Address already in use: 8080`

**Solution:** Stop conflicting services or change port mappings:

```bash
# Find process using port
lsof -ti:8080 | xargs kill -9

# Or use different ports in docker run
docker run -p 8081:8080 ...
```

---

## 🤝 Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for details on:

- Code of Conduct
- Development workflow
- How to submit pull requests
- Coding standards

### Quick Contribution Guide

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 🔒 Security

Security is a top priority. This project implements:

- ✅ Non-root user execution
- ✅ Minimal base image (Ubuntu LTS)
- ✅ Regular dependency updates
- ✅ No hardcoded secrets
- ✅ Security scanning ready

**Found a vulnerability?** Please report it responsibly via [SECURITY.md](SECURITY.md).

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- [Apache Spark](https://spark.apache.org/) - The engine behind big data processing
- [VS Code Remote Containers](https://code.visualstudio.com/docs/remote/containers) - Excellent development experience
- [Docker](https://www.docker.com/) - Containerization platform
- The open-source community for continuous inspiration

---

## 📞 Support

- 📖 [Documentation](https://github.com/yourusername/vscode_dev_docker/wiki)
- 🐛 [Issue Tracker](https://github.com/yourusername/vscode_dev_docker/issues)
- 💬 [Discussions](https://github.com/yourusername/vscode_dev_docker/discussions)
- 🔄 [Spark 4.0 Migration Guide](SPARK_4_MIGRATION.md)
- ⭐ Star this repo if you find it useful!

---

Made with ❤️ for the data engineering community
