FROM node:24-bookworm
RUN curl -sSL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o /tmp/awscliv2.zip \
    && unzip -q /tmp/awscliv2.zip -d /tmp \
    && /tmp/aws/install \
    && rm -rf /tmp/awscliv2.zip /tmp/aws
RUN corepack enable && corepack prepare pnpm@11.1.3 --activate
RUN node --version && pnpm --version && aws --version
