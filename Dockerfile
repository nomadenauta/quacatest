FROM python:3.7-slim
FROM guacamole/guacamole

RUN set -xe \
    && apt-get update \
    && apt-get install python3-pip
    
RUN pip3 install --upgrade pip
    
RUN pip install --upgrade pip

RUN pip install --no-cache --upgrade pip && \
    pip install --no-cache notebook

ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
    
# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}
