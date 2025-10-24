FROM almalinux:9
RUN dnf update -y && \
    dnf install -y wget rpmdevtools rpm-build createrepo yum-utils cmake gcc git nano nginx lynx && \
    dnf clean all

WORKDIR /root
EXPOSE 80
CMD ["/bin/bash"]
