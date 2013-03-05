# service.sylab.ee.ntu.edu.tw

SYLab Net Service Infomation Site

Daily Snapshots Demo  http://service.sylab.ee.ntu.edu.tw

## Setup develop enviroment

### Setup RVM
Please reference the link

http://www.andrehonsberg.com/article/install-rvm-ubuntu-1204-linux-for-ruby-193

### Add alias for ruby gems commands

```bash
vi ~/.bashrc
```

add following line below

```bash
# rvm and ruby-gems commands
alias rgl='rvm gemset list'
alias rgu='rvm gemset use'
alias rgc='rvm gemset create'
alias rgd='rvm gemset delete'
alias gl='gem list'
alias gi='gem install --no-rdoc'
```

reload bashrc file

```bash
source ~.bashrc
```

### Clone Project

```bash
cd ~/ && mkdir workspace && cd workspace
git clone git@github.com:JustinTW/service.sylab.git
```
`if you want to contribute code, you must fork project before this step.`

### Add gemset for this project

```bash
rgc service.sylab
```

### Install Gems

```bash
cd ~/workspace/service.sylab.git
bundle install
```

### Start Rails

```bash
rails s
```

For now, you can access this project on http://{ip}:3000


