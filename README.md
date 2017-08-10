# dotfiles

## Additional config

### dconf

Enable select of URLs by double-clicking
```
dconf write /org/gnome/terminal/legacy/profiles:/:${profileid}/word-char-exceptions '@ms "-=&#:/.?@+~_%;"'
```
