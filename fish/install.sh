# Always overwrite the default config.
ln -s $HOME/.fish $HOME/.config/fish;

# Set shell
sudo sh -c "echo $(which fish) >> /etc/shells"
