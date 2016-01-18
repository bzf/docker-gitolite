FROM debian:8
MAINTAINER André Ligné "andre.ligne@gmail.com"

# Install dependencies
RUN apt-get update && apt-get -y install git ssh

# Add a `git` user
RUN useradd -m git
RUN chown -R git /home/git/
USER git
WORKDIR /home/git

# Download latest version of `gitolite`
RUN git clone git://github.com/sitaramc/gitolite /tmp/gitolite
RUN /tmp/gitolite/install -to /home/git/

# Copy over the initialize script
COPY ./initialize.sh /bin/initialize.sh

# Run the service
USER root
EXPOSE 22
RUN mkdir -p /var/run/sshd

ENTRYPOINT /bin/initialize.sh
