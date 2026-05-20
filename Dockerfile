FROM node:24-bookworm
ARG TARGETARCH
RUN case "$TARGETARCH" in \
        amd64) AWS_CLI_ARCH=x86_64 ;; \
        arm64) AWS_CLI_ARCH=aarch64 ;; \
        *) echo "unsupported arch: $TARGETARCH"; exit 1 ;; \
    esac \
    && curl -sSL "https://awscli.amazonaws.com/awscli-exe-linux-${AWS_CLI_ARCH}.zip" -o /tmp/awscliv2.zip \
    && unzip -q /tmp/awscliv2.zip -d /tmp \
    && /tmp/aws/install \
    && rm -rf /tmp/awscliv2.zip /tmp/aws
RUN corepack enable && corepack prepare pnpm@11.1.3 --activate
RUN node --version && pnpm --version && aws --version
