omgbzf/gitolite
===============

A container for running a `gitolite` server inside Docker based off of
debian:8.

## Running the container
```sh
PORT=2223

# Setup the `admin` user in `gitolite`
docker run -d -e "SSH_KEY=$(cat ~/.ssh/id_rsa.pub)" -p 2223:22 -t omgbzf/gitolite

# Later you can start it without the `SSH_KEY` env
docker run -d -p 2223:22 -t omgbzf/gitolite
```

Then you should be able to clone the `gitolite-admin` repository using:
```sh
REMOTE=$(docker-machine ip $(docker-machine active))

# Using ssh protocol to define which port to use on the remote server
git clone ssh://git@$REMOTE:2223/gitolite-admin.git
```

## Running with a data container

For this container to be useful you need to create a data container for storing
all of the repositories.

To create a data container you run:
```sh
docker create -v /home/git --name gitolite-data omgbzf/gitolite /bin/true
```

When you want to start the container you tell it to use the data container you
just created:
```sh
docker run --volumes-from=gitolite-data -d -p 2223:22 -t omgbzf/gitolite
```

Now you should be able to do changes, restart the service and see that your
changes have been persisted.

## TODO
- [x] Add instructions for running the stuff (with data container)
- [ ] Fix the `locale` warnings
