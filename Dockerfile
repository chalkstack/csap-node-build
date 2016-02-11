
FROM ubuntu:14.04
MAINTAINER Jake Bouma <jake@chalkstack.co.za>
ENV DEBIAN_FRONTEND noninteractive

# Grab some basics & install python
RUN apt-get update && apt-get install -y \
    git \
    bzip2 \
    curl \
    python python-dev python-pip

# Install PyRFC v1.9.4
# See PyRFC project at sap.github.io/pyrfc
RUN pip install Cython==0.22.1
COPY nwrfcsdk /usr/sap/nwrfcsdk
COPY nwrfcsdk.conf /etc/ld.so.conf.d/nwrfcsdk.conf
RUN ldconfig
ENV SAPNWRFC_HOME="/usr/sap/nwrfcsdk"
RUN git clone https://github.com/SAP/PyRFC.git /tmp/PyRFC/
RUN curl https://bootstrap.pypa.io/ez_setup.py > /tmp/ez_setup.py
RUN python /tmp/ez_setup.py
RUN easy_install /tmp/PyRFC/dist/pyrfc-1.9.4-py2.7-linux-x86_64.egg

# Get csap-node
RUN mkdir /csap
RUN git clone https://github.com/chalkstack/csap-node /csap/csap-node
RUN pip install -r /csap/csap-node/requirements.txt

# Housekeeping
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Create default, non-root user
RUN useradd -c 'ChalkSAP User' -m -d /home/cks -s "/bin/bash" cks \
    && echo "cks:cks" | chpasswd \
    && adduser cks sudo
USER cks
WORKDIR /home/cks
