ARG PYTHON_VERSION=36

FROM registry.access.redhat.com/ubi7/python-${PYTHON_VERSION}:latest
USER root

# ANSIBLE VERSION
ENV ANSIBLE_VERSION 2.8.5

ENV HOME=/home/

RUN yum install -y --disableplugin=subscription-manager https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum install -y --disableplugin=subscription-manager nodejs sshpass

RUN echo 'root:Docker!' | chpasswd

RUN	pip install --upgrade pip && \
    pip install --no-cache-dir virtualenv && \
    pip install --upgrade setuptools && \
    pip install --upgrade openshift

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


RUN chmod -R 777 ${HOME} /etc/passwd /etc/group

USER node

EXPOSE 22
ENTRYPOINT ["bash", "/entrypoint.sh"]
