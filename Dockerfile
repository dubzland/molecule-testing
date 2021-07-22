FROM jdubz/asdf-alpine:1.0.0

ARG install_python_versions="3.6.12 3.6.13 3.6.14 3.7.9 3.7.10 3.7.11 3.8.9 3.8.10 3.8.11 3.9.4 3.9.5 3.9.6"
ARG global_python_version="3.9.6"

RUN apk add --no-cache \
		build-base \
		bzip2-dev \
		cargo \
		gcc \
		libffi-dev \
		openssl-dev \
		readline-dev \
		rust \
		sqlite-dev \
		zlib-dev && \
	source $HOME/.asdf/asdf.sh && \
	for p in $install_python_versions; do \
		asdf install python $p && \
		asdf shell python $p && \
		pip install wheel; \
	done && \
	asdf global python $global_python_version && \
	pip install tox tox-asdf && \
	asdf reshim python
