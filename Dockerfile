FROM jdubz/asdf-alpine:1.1.0

LABEL maintainer="jdubz@dubzland.net"

ARG install_python_versions="3.8.13 3.9.13 3.10.6"
ARG global_python_version="3.10.6"

LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.build-date="2022-08-23"
LABEL org.label-schema.name="jdubz/molecule-testing"
LABEL org.label-schema.description="Alpine with asdf-managed build tools"
LABEL org.label-schema.vcs-url="https://git.dubzland.net/dubzland/molecule-testing/"

ENV TOX_WORK_DIR="/work/.tox"

RUN source $ASDF_DIR/asdf.sh && \
	for p in $install_python_versions; do \
		asdf install python $p && \
		asdf shell python $p && \
		pip install --upgrade pip && \
		pip install --upgrade setuptools && \
		pip install wheel; \
	done

RUN source $ASDF_DIR/asdf.sh && \
	asdf global python $global_python_version && \
	asdf shell python $global_python_version && \
	pip install tox tox-asdf molecule && \
	asdf reshim python
