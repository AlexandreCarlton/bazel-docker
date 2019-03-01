FROM ubuntu:18.04

ARG BAZEL_VERSION

RUN apt-get update && \
    apt-get install -y \
      curl \
      gnupg2 \
      openjdk-8-jdk \
      python3-pip && \
    echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" \
    > /etc/apt/sources.list.d/bazel.list && \
    curl https://bazel.build/bazel-release.pub.gpg \
    | apt-key add - && \
    apt-get update && \
    apt-get install -y \
      bazel && \
    rm -rf /var/libapt/lists/*

ENTRYPOINT ["/usr/bin/bazel"]
