# SSH into PACE

## Configuring ssh host aliases

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

## Updating pace-interactive alias

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

## Generate SSH keys on your personal computer
[**Reference:** Generating a new SSH key and adding it to the ssh-agent](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

Using GitHub CLI:

```
# Install GitHub CLI if you don't have it yet
# Linux: Follow instructions at https://github.com/cli/cli/blob/trunk/docs/install_linux.md
# macOS: brew install gh
# Windows: winget install --id GitHub.cli

# Generate an SSH key pair
ssh-keygen -t ed25519 -C "your_email@example.com"

# Start the SSH agent
eval "$(ssh-agent -s)"

# Add your SSH key to the agent
ssh-add ~/.ssh/id_ed25519

# Copy your public key to clipboard (Linux)
cat ~/.ssh/id_ed25519.pub | xclip -selection clipboard

# For macOS: cat ~/.ssh/id_ed25519.pub | pbcopy
# For Windows: cat ~/.ssh/id_ed25519.pub | clip
```

## Add authorized keys to PACE

```
# Log into PACE
ssh myuser@login-phoenix.pace.gatech.edu

# Create .ssh directory if it doesn't exist
mkdir -p ~/.ssh

# Create or append to authorized_keys file
nano ~/.ssh/authorized_keys

# Paste your public key, save and exit (Ctrl+O, Enter, Ctrl+X)

# Test your connection from your local machine
ssh pace
```
