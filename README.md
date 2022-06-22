# nvim
my neovim config
![image](https://user-images.githubusercontent.com/45741682/174918041-2a911ecc-8a7c-47be-8c9a-5a21c45270a8.png)

![image](https://user-images.githubusercontent.com/45741682/174918168-4a83085e-6c6a-4e2f-bef1-8360117173fc.png)

## Install
Make sure you have the neovim 0.7.0+ installed.  
```
pacman -Qi neovim | grep -Po '^Version\s*: \K.+'
```

Clone this under your ~/.config/nvim directory (this overwrites your old neovim config, so make a backup)  
```
cp -r ~/.config/nvim ~/.config/nvim-backup
git clone https://github.com/AsianKoala/nvim.git ~/.config/nvim
```
Then run `nvim` to set everything up
