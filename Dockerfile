FROM nvidia/cuda:13.3.0-cudnn-runtime-ubuntu24.04
WORKDIR /breezyvoice

ENV UV_LINK_MODE=copy
ENV PATH="/root/.local/bin/:$PATH"

ADD https://astral.sh/uv/install.sh /uv-installer.sh

RUN apt update -y && apt upgrade -y && \
    apt install -y --no-install-recommends curl ca-certificates ffmpeg && \
    sh /uv-installer.sh && rm /uv-installer.sh && \
    apt clean -y && rm -rf /var/lib/apt/lists/* && \
    uv venv -p 3.10

COPY pyproject.toml uv.lock ./

RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --locked

COPY . .

EXPOSE 8080

ENTRYPOINT ["/breezyvoice/.venv/bin/python"]
