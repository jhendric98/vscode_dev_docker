# Master Spark Dev Container Dockerfile for VSCode

This project is to track the Dockerfiles for use in Spark development. This assumes VSCode is installed and fucntional. This was created with the latest versions of each component. You should examine your production environment for supported versions and adjust as needed.

## Requirements
1. VSCode with path environent setup
2. Remote development extension
3. You may want Scala Metals and Docker extensions

## To use
1. Create a project directory and copy the Dockerfile into the project root directory.
2. Start VSCode using: code .
3. Once the IDE launches you should get a prompt to Reopen in the container.
4. Continue development setup as needed. 
5. Once the container is launched, you can start a Spark local cluster as follows:
    - a. start-master.sh
    - b. start-workers.sh spark://localhost:7077

## TODO
1. Create release tags for each cloud environment.
2. Add scala install.
