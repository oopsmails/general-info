
# Dive

- Ref:
https://medium.com/nexton/how-to-optimize-docker-images-using-dive-dc590f45dbf5

## What
Dive is a tool to analyze Docker images. The most important features that it provides are:

- Shows Docker image contents broken down by layer
- Indicate what’s changed in each layer
- Estimate “image efficiency”
- Quick build/analysis cycles
You can build a Docker image and do an immediate analysis with one command: dive build -t some-tag .
- CI Integration


## Installation
Installation instructions for almost every platform is available on the tool GitHub repository. 

https://github.com/wagoodman/dive/blob/master/README.md

### Ubuntu/Debian

wget https://github.com/wagoodman/dive/releases/download/v0.9.2/dive_0.9.2_linux_amd64.deb
sudo apt install ./dive_0.9.2_linux_amd64.deb

### An interesting option is to use Docker directly to run it:
Not tested

```
docker pull wagoodman/dive
docker run --rm -it \
    -v /var/run/docker.sock:/var/run/docker.sock \
    wagoodman/dive:latest <dive arguments...>

```
## Usage example
Let’s start using this Node.js API code to build and analyze:
```
git clone https://github.com/nexton-labs/node-starter.git
cd node-starter
dive build -t node-starter .

```




