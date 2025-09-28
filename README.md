# Master Spark Dev Container Dockerfile for VS Code

This repository contains a hardened Dockerfile that provisions a reproducible Apache Spark development environment tailored for Visual Studio Code's remote containers. The image ships with updated tooling, secure defaults, and common developer utilities so you can get started quickly.

## What's included

| Component | Version/Notes |
|-----------|---------------|
| Base image | Ubuntu 22.04 LTS |
| Java | OpenJDK 11 |
| Apache Spark | 3.5.1 (Hadoop 3) |
| Scala | 2.13 (via Ubuntu package) |
| Build tools | Maven, SBT |
| Python | Python 3 with `pip` |
| Utilities | Git, Bash completion, Curl, Wget |

Environment variables are set automatically:

```bash
export SPARK_HOME=/opt/spark
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
export PATH="$SPARK_HOME/bin:$SPARK_HOME/sbin:$PATH"
```

## Requirements

1. Visual Studio Code with the command-line `code` launcher configured.
2. The VS Code **Remote Development** extension pack.
3. Optional but recommended: Scala Metals extension and Docker Desktop (or another Docker runtime).

## Usage

1. Create or open a project directory.
2. Copy the `Dockerfile` into the project root (or reference it from a `devcontainer.json`).
3. Launch VS Code from the project folder using `code .`.
4. When prompted by VS Code, select **Reopen in Container** to build the image and attach to it.
5. After the container starts you can launch a local Spark master and worker for testing:
   ```bash
   start-master.sh
   start-worker.sh spark://localhost:7077
   ```
6. Continue configuring your project (e.g., dependencies, settings) as required.

## Customization tips

- Override the Spark or Hadoop versions by passing build arguments, for example:
  ```bash
  docker build --build-arg SPARK_VERSION=3.5.0 --build-arg HADOOP_VERSION=3 .
  ```
- Add additional tools by extending the Dockerfile and appending more `apt-get install` packages.
- To reduce image size further, remove packages you do not need (such as Python or Maven).

## TODO

- Create release tags for each cloud environment profile.
- Automate CI validation of the container build.
