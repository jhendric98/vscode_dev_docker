# syntax=docker/dockerfile:1

# Apache Spark Development Container
# Optimized for VS Code Remote Containers
# Security-hardened with non-root user execution

FROM ubuntu:22.04

# Metadata labels
LABEL maintainer="Your Name <your.email@example.com>"
LABEL description="Apache Spark development environment for VS Code"
LABEL version="1.0.0"
LABEL org.opencontainers.image.source="https://github.com/yourusername/vscode_dev_docker"
LABEL org.opencontainers.image.licenses="MIT"

# Build arguments for version control
ARG DEBIAN_FRONTEND=noninteractive
ARG SPARK_VERSION=4.0.1
ARG HADOOP_VERSION=3
ARG SPARK_USER=sparkuser
ARG SPARK_UID=1000
ARG SPARK_GID=1000

# Environment variables
ENV SPARK_HOME=/opt/spark \
    JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64 \
    PATH=/opt/spark/bin:/opt/spark/sbin:$PATH \
    SPARK_USER=${SPARK_USER} \
    PYTHONUNBUFFERED=1

# Set shell options for pipefail
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install system dependencies and development tools
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates=20230311ubuntu0.22.04.1 \
        curl=7.81.0-1ubuntu1.18 \
        gnupg=2.2.27-3ubuntu2.1 \
        lsb-release=11.1.0ubuntu4 \
    # Add SBT repository
    && echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | tee /etc/apt/sources.list.d/sbt.list \
    && echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | tee /etc/apt/sources.list.d/sbt_old.list \
    && curl -fsSL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" \
        | gpg --dearmor -o /etc/apt/trusted.gpg.d/scalasbt-release.gpg \
    # Install development tools
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        bash-completion=1:2.11-5ubuntu1 \
        git=1:2.34.1-1ubuntu1.12 \
        maven=3.6.3-5 \
        openjdk-11-jdk=11.0.25+9-1ubuntu1~22.04 \
        procps=2:3.3.17-6ubuntu2.1 \
        python3=3.10.6-1~22.04.1 \
        python3-pip=22.0.2+dfsg-1ubuntu0.4 \
        python3-venv=3.10.6-1~22.04.1 \
        sbt=1.10.6 \
        scala=2.11.12-5 \
        sudo=1.9.9-1ubuntu2.4 \
        vim=2:8.2.3995-1ubuntu2.22 \
        wget=1.21.2-2ubuntu1.1 \
    # Clean up to reduce image size
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Download and install Apache Spark
RUN mkdir -p ${SPARK_HOME} \
    && curl -fsSL "https://downloads.apache.org/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz" \
        -o /tmp/spark.tgz \
    && tar -xzf /tmp/spark.tgz -C /opt \
    && mv /opt/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} ${SPARK_HOME} \
    && rm /tmp/spark.tgz \
    # Verify Spark installation
    && ${SPARK_HOME}/bin/spark-submit --version

# Install Python packages commonly used with Spark
RUN pip3 install --no-cache-dir --upgrade pip==24.2 setuptools==75.1.0 wheel==0.44.0 \
    && pip3 install --no-cache-dir \
        pytest==8.3.3 \
        black==24.10.0 \
        flake8==7.1.1 \
        pylint==3.3.1 \
        ipython==8.28.0 \
        jupyter==1.1.1 \
        numpy==2.1.2 \
        pandas==2.2.3 \
        pyarrow==17.0.0

# Create non-root user for security
RUN groupadd -r ${SPARK_USER} -g ${SPARK_GID} \
    && useradd -l -u ${SPARK_UID} -r -g ${SPARK_USER} -m -d /home/${SPARK_USER} -s /bin/bash ${SPARK_USER} \
    && echo "${SPARK_USER} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${SPARK_USER} \
    && chmod 0440 /etc/sudoers.d/${SPARK_USER}

# Set up workspace directory with proper permissions
RUN mkdir -p /workspace \
    && chown -R ${SPARK_USER}:${SPARK_USER} /workspace \
    && chown -R ${SPARK_USER}:${SPARK_USER} ${SPARK_HOME}

# Set up bash completion for spark user
RUN echo "source /etc/bash_completion" >> /home/${SPARK_USER}/.bashrc \
    && echo "export SPARK_HOME=${SPARK_HOME}" >> /home/${SPARK_USER}/.bashrc \
    && echo "export JAVA_HOME=${JAVA_HOME}" >> /home/${SPARK_USER}/.bashrc

# Switch to non-root user
USER ${SPARK_USER}
WORKDIR /workspace

# Health check to verify Spark is operational
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD ${SPARK_HOME}/bin/spark-submit --version || exit 1

# Expose common Spark ports
# 4040: Spark UI
# 7077: Spark Master
# 8080: Spark Master Web UI
# 8081: Spark Worker Web UI
# 18080: Spark History Server
EXPOSE 4040 7077 8080 8081 18080

# Default command
CMD ["/bin/bash"]
