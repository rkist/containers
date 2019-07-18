FROM ubuntu:18.10

RUN apt-get update && apt-get install -y vim curl git wget zsh mysql-client gcc make zlib1g-dev libssl-dev 

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

RUN curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

RUN echo 'export PATH="$HOME/.pyenv/bin:$PATH"\n\
eval "$(pyenv init -)"\n\
eval "$(pyenv virtualenv-init -)"' >> ~/.zshrc

RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash

RUN echo 'export NVM_DIR="$HOME/.nvm" \n\
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm \n\
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> ~/.zshrc

RUN curl -fsSL https://get.docker.com | sh

RUN curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

RUN chmod +x /usr/local/bin/docker-compose

RUN echo "alias dc='docker-compose'" >> ~/.zshrc

WORKDIR /projects

CMD trap : TERM INT; sleep infinity & wait