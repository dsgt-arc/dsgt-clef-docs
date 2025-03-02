# ssh with pace

## configuring ssh host aliases

It is useful to setup your `~/.ssh/config` on your host as follows:

```
Host pace
    HostName login-phoenix.pace.gatech.edu
    User amiyaguchi3

# update this using update-pace-interactive.sh
Host pace-interactive
  HostName atl1-1-02-007-30-1.pace.gatech.edu
  User amiyaguchi3
  ProxyJump pace
```

This adds an host alias `pace` and `pace-interactive`.

Make sure to add your ssh key to the `~/.ssh/authorized_keys` section after logging into pace via `ssh myuser@login-phoenix.pace.gatech.edu`.

You can now access pace using `ssh pace` and it will automatically log you in.
The `pace-interactive` alias will use the login node as a jump host, allowing you to run vscode sessions on interactive sessions.

## updating pace-interactive alias

Allocate a new interactive session on pace.
For example:

```bash
salloc --account=paceship-dsgt_clef2025 --nodes=1 --ntasks=1 --cpus-per-task=8 --mem-per-cpu=4G --time=2:00:00 --qos=inferno
```

Make sure to keep this terminal around.
Get the hostname from the session:

```
$ hostname
atl1-1-02-007-30-1.pace.gatech.edu
```

Copy the hostname and pass it as an argument to the [`update-pace-interactive.sh`](./update-pace-interactive.sh) script.
Then you can ssh via `ssh pace-interactive` from your host machine through the terminal or vscode.

Note that this will also allow you to port forward any services running on these nodes.


Read more about SSH config files: https://linux.die.net/man/5/ssh_config
