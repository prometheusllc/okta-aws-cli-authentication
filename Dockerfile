FROM ubuntu

# author
MAINTAINER Jeremiah Gearheart

# extra metadata
LABEL version="1.0"
LABEL description="Ubuntu Container running okta-aws assume role tool"

# update sources list
RUN apt-get clean
RUN apt-get update
RUN echo Y | apt-get upgrade

# install basic apps, one per line for better caching
RUN apt-get install -qy git
RUN apt-get install -qy locales
RUN apt-get install -qy nano
RUN apt-get install -qy tmux
RUN apt-get install -qy wget
RUN apt-get install -qy curl

# install app runtimes and modules
RUN apt-get update && \
    apt-get install -y \
        python \
        python-pip \
        python-setuptools \
        groff \
        less \
    && pip --no-cache-dir install --upgrade awscli \
    && apt-get clean
RUN export PATH=~/.local/bin:$PATH
RUN echo Y | apt install default-jdk
RUN echo Y | apt install maven
RUN PREFIX=~/.okta 
RUN cd $HOME && wget https://raw.githubusercontent.com/oktadeveloper/okta-aws-cli-assume-role/master/bin/install.sh
RUN cd $HOME && chmod +x install.sh
RUN cd $HOME && bash install.sh -i
#check installs
RUN java -version
RUN mvn -version

#Configure Paths and add shell script to run okta-aws command
COPY bash_profile /
COPY getcreds.sh /
RUN cat bash_profile >> ~/.bash_profile && cat bash_profile >> ~/.bashrc && chmod +x getcreds.sh

# cleanup
RUN apt-get -qy autoremove
