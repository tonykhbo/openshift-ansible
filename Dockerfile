ARG PYTHON_VERSION=36

FROM registry.access.redhat.com/ubi7/python-${PYTHON_VERSION}:latest
USER root

# ANSIBLE VERSION
ENV ANSIBLE_VERSION 2.8.5

ENV HOME=/home/

RUN yum install -y --disableplugin=subscription-manager https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum install -y --disableplugin=subscription-manager nodejs sshpass

RUN	pip install --upgrade pip && \
    pip install --no-cache-dir virtualenv && \
    pip install --upgrade setuptools

RUN pip install "ansible==${ANSIBLE_VERSION}" \
	pylint \
	pyinotify \
	apache-libcloud \
	google-cloud \
	azure \
	boto \
	boto3 \
	docker \
	ovirt-engine-sdk-python \
	pyvmomi \
	netaddr \
	requests \
	"idna<2.8" \
	ansible-tower-cli \
	"pexpect==4.6.0" \
	python-memcached \
	molecule \
	xmltodict \
	ncclient \
	f5-sdk \
	f5-icontrol-rest \
	passlib \
	pandevice \
	pan-python \
	avisdk \
	ansible-review \
	infoblox-client \
	jmespath \
	yaql \
	"click==6.7" \
	"colorama==0.3.9" \
	"Jinja2==2.10.1" \
	"PyYAML<6,>=5.1" \
	"six==1.11.0"

RUN curl -s -o /tmp/oc.tar.gz https://mirror.openshift.com/pub/openshift-v3/clients/3.10.176/linux/oc.tar.gz && \
    tar -C /usr/local/bin -zxf /tmp/oc.tar.gz oc && \
    mv /usr/local/bin/oc /usr/local/bin/oc-3.10 && \
    rm /tmp/oc.tar.gz && \
    curl -s -o /tmp/oc.tar.gz https://mirror.openshift.com/pub/openshift-v3/clients/3.11.153/linux/oc.tar.gz && \
    tar -C /usr/local/bin -zxf /tmp/oc.tar.gz oc && \
    mv /usr/local/bin/oc /usr/local/bin/oc-3.11 && \
    rm /tmp/oc.tar.gz && \
    curl -s -o /tmp/oc.tar.gz https://mirror.openshift.com/pub/openshift-v3/clients/4.0.22/linux/oc.tar.gz && \
    tar -C /usr/local/bin -zxf /tmp/oc.tar.gz oc && \
    mv /usr/local/bin/oc /usr/local/bin/oc-4.0 && \
    rm /tmp/oc.tar.gz && \
    curl -s -o /tmp/oc.tar.gz https://mirror.openshift.com/pub/openshift-v4/clients/oc/4.1/linux/oc.tar.gz && \
    tar -C /usr/local/bin -zxf /tmp/oc.tar.gz oc && \
    mv /usr/local/bin/oc /usr/local/bin/oc-4.1 && \
    ln -s /usr/local/bin/oc-4.1 /usr/local/bin/kubectl-1.13 && \
    rm /tmp/oc.tar.gz && \
    curl -s -o /tmp/oc.tar.gz https://mirror.openshift.com/pub/openshift-v4/clients/oc/4.2/linux/oc.tar.gz && \
    tar -C /usr/local/bin -zxf /tmp/oc.tar.gz oc && \
    mv /usr/local/bin/oc /usr/local/bin/oc-4.2 && \
    ln -s /usr/local/bin/oc-4.2 /usr/local/bin/kubectl-1.14 && \
    rm /tmp/oc.tar.gz && \
    curl -s -o /tmp/oc.tar.gz https://mirror.openshift.com/pub/openshift-v4/clients/oc/4.3/linux/oc.tar.gz && \
    tar -C /usr/local/bin -zxf /tmp/oc.tar.gz oc && \
    mv /usr/local/bin/oc /usr/local/bin/oc-4.3 && \
    ln -s /usr/local/bin/oc-4.3 /usr/local/bin/kubectl-1.16 && \
    rm /tmp/oc.tar.gz

RUN curl -sL -o /usr/local/bin/odo-0.0.16 https://github.com/openshift/odo/releases/download/v0.0.16/odo-linux-amd64 && \
    chmod +x /usr/local/bin/odo-0.0.16 && \
    curl -sL -o /usr/local/bin/odo-0.0.17 https://github.com/openshift/odo/releases/download/v0.0.17/odo-linux-amd64 && \
    chmod +x /usr/local/bin/odo-0.0.17 && \
    curl -sL -o /usr/local/bin/odo-0.0.18 https://github.com/openshift/odo/releases/download/v0.0.18/odo-linux-amd64 && \
    chmod +x /usr/local/bin/odo-0.0.18 && \
    curl -sL -o /usr/local/bin/odo-0.0.19 https://github.com/openshift/odo/releases/download/v0.0.19/odo-linux-amd64 && \
    chmod +x /usr/local/bin/odo-0.0.19 && \
    curl -sL -o /usr/local/bin/odo-0.0.20 https://github.com/openshift/odo/releases/download/v0.0.20/odo-linux-amd64 && \
    chmod +x /usr/local/bin/odo-0.0.20 && \
    curl -sL -o /tmp/odo.tar.gz https://mirror.openshift.com/pub/openshift-v4/clients/odo/v1.0.0/odo-linux-amd64.tar.gz && \
    tar -C /tmp -xf /tmp/odo.tar.gz && \
    mv /tmp/odo /usr/local/bin/odo-1.0 && \
    chmod +x /usr/local/bin/odo-1.0 && \
    rm /tmp/odo.tar.gz

# Install Kubernetes client.

RUN curl -sL -o /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v1.10.0/bin/linux/amd64/kubectl && \
    mv /usr/local/bin/kubectl /usr/local/bin/kubectl-1.10 && \
    chmod +x /usr/local/bin/kubectl-1.10 && \
    curl -sL -o /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v1.11.0/bin/linux/amd64/kubectl && \
    mv /usr/local/bin/kubectl /usr/local/bin/kubectl-1.11 && \
    chmod +x /usr/local/bin/kubectl-1.11 && \
    curl -sL -o /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v1.12.0/bin/linux/amd64/kubectl && \
    mv /usr/local/bin/kubectl /usr/local/bin/kubectl-1.12 && \
    chmod +x /usr/local/bin/kubectl-1.12


RUN chmod -R 777 ${HOME} /etc/passwd /etc/group

USER node

ENTRYPOINT ["bash", "/entrypoint.sh"]

© 2020 GitHub, Inc.
Terms
Privacy
Security
Status
Help
Contact GitHub
Pricing
API
Training
Blog
About
