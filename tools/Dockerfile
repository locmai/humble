FROM archlinux

# Sort mirrors by speed
RUN pacman --sync --refresh --noconfirm \
        reflector \
    && reflector \
        --save /etc/pacman.d/mirrorlist \
        --protocol https \
        --latest 20 \
        --sort rate

RUN yes | pacman --sync --refresh \
        ansible \
        ansible-lint \
        argocd \
        diffutils \
        docker \
        docker-compose \
        git \
        glibc \
        graphviz \
        helm \
        kubectl \
        kustomize \
        libisoburn \
        make \
        p7zip \
        python \
        python-kubernetes \
        python-netaddr \
        python-pip \
        terraform \
        terragrunt \
        wget

RUN wget -O /usr/local/bin/k3d https://github.com/k3d-io/k3d/releases/download/v5.4.1/k3d-linux-amd64 

RUN chmod +x /usr/local/bin/k3d

RUN pip install docker-compose
