#Chalksap data extraction server

A dockerized http server that isolates the installation dependencies of [`PyRFC`](http://sap.github.io/PyRFC)
into a container and exposes limited download capabilities via http requests.

##Installation

Clone the repository
    
    git clone https://github.com/chalkstack/csap-node-build

Copy `nwrfcsdk` into the freshly cloned directory

    cp nwrfcsdk csap-node-build
    
Build the image with Docker

    docker build --tag=csap/base ./

Run the image

    docker run -ti csap/base
    
By default, starts the server on the container's `localhost:5101`.
Map the ports with docker run to the host machine as needed.
