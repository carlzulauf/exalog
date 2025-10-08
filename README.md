# exalog

Personal blog/playground app. Eventually replacing underbee, maybe.

## Development Setup

I move between machines a lot so putting some reminders here.

### NixOS

Probably going to just use docker in nix.

Don't have docker compose setup (yet?), but it's just sqlite so single process should work.

```
docker build . -t exalog
docker run -e RAILS_MASTER_KEY='***SEE PASSWORD MANAGER***' -p 3000:3000 exalog
```

The container won't see new files until after a restart, so we should really get compose working.

### distrobox

Using distrobox in environments where running native is hard (nix/silverblue/etc).

Put master key into `config/master.key` to make this easier.

At time of writing, this is the same base image the `Dockerfile` uses. Uses container's package manager to install the same packages as `Dockerfile`, plus a few extra (tmux dotenv)

```
distrobox create --image docker.io/library/ruby:3.4.4 --name ruby344
distrobox enter ruby344
# now inside container
sudo apt-get install --no-install-recommends -y curl libjemalloc2 libvips42 \
  sqlite3 build-essential git libyaml-dev pkg-config \
  tmux dotenv
bundle install
rails server
```

Now we can just enter the box and run rails commands whenever. Adding `tmux` allows us to start with `tproj`:

```
tproj --distrobox=ruby344 exalog
```
