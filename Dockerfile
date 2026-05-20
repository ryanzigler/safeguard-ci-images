# CI image for the safeguard-astro pipeline.
# Bakes in Node 24, pnpm 11.1.3 (via corepack), and AWS CLI v2 so Bitbucket
# Pipelines steps don't have to install them on every run.
FROM node:24-bookworm

# AWS CLI v2 — binary install, no Python dependency.
RUN curl -sSL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o /tmp/awscliv2.zip \
    && unzip -q /tmp/awscliv2.zip -d /tmp \
    && /tmp/aws/install \
    && rm -rf /tmp/awscliv2.zip /tmp/aws

# Pre-prepare pnpm 11.1.3 (used by the main build step).
# Other steps can still `corepack prepare pnpm@<version> --activate` on demand.
RUN corepack enable && corepack prepare pnpm@11.1.3 --activate

# Smoke test at build time so a broken image fails fast.
RUN node --version && pnpm --version && aws --version
