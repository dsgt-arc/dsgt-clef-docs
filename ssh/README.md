# SSH into PACE



## Authenticate to GitHub using GitHub CLI
This section streamlines the authentication process to GitHub using the 
GitHub CLI `gh`, which simplifies the SSH setup. 

You can find the [**GitHub CLI installation instructions**](https://github.com/cli/cli#installation) here.

1. Run `gh auth login` to begin the authentication process.
2. When prompted, select **SSH** as the preferred protocol for Git operations.
3. If you don't already have an SSH key, `gh` will prompt you to generate one. Follow the on-screen instructions to create a new SSH key.
4. `gh` will automatically add your SSH key to your GitHub account. Follow any additional prompts to complete the process.
5. After completing the setup, run `gh auth status` to check if you're successfully authenticated.

If you want to do it manually check the GitHub page:
[**Reference:** Generating a new SSH key and adding it to the ssh-agent](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

## Verify GitHub User Information (Optional)
It's good practice to ensure your Git identity is correctly set:
1. **Check Git Configurations:** Run `git config --list` to see your Git configurations, including user name and email.
2. **Set Git User Information If Not Set:** If not already set, configure your Git user information:
```
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
```
Replace with your GitHub email and name.

## Configuring SSH host aliases

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

## Add authorized keys to PACE

```
# Log into PACE
ssh pace

# Create .ssh directory if it doesn't exist
mkdir -p ~/.ssh

# Create or append to authorized_keys file
nano ~/.ssh/authorized_keys

# Paste your public key, save and exit (Ctrl+O, Enter, Ctrl+X)

# Test your connection from your local machine
ssh pace
```


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
