NOTE
---

* You used to Zgen to manage plugins (base on `.zgen/...`)


## ✅ Case 1: Begin Oh My Zsh

### 1. Remove Zgen configuration

```bash
rm -rf ~/.zgen
```

### 2. Oh My Zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### 3. Set up plugins

**zsh-autosuggestions:**

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

**zsh-syntax-highlighting:**

```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

**powerlevel10k:**

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
```

Then, modify `.zshrc`:

```zsh
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
```

---

## ✅ **Case 2: Reuse Zgen (Manage plugin by Zgen)**

### 1. Set up Zgen:

```bash
git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
```

### 2. In `.zshrc`

```zsh
source "${HOME}/.zgen/zgen.zsh"

if ! zgen saved; then
  zgen oh-my-zsh
  zgen oh-my-zsh plugins/git
  zgen oh-my-zsh plugins/zsh-autosuggestions
  zgen oh-my-zsh plugins/zsh-syntax-highlighting
  zgen load romkatv/powerlevel10k powerlevel10k
  zgen save
fi
```

### 3. Reload:

```bash
exec zsh
```
