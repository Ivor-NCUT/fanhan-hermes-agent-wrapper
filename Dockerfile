FROM docker.io/nousresearch/hermes-agent:v2026.6.5

CMD ["/opt/hermes/bin/hermes", "gateway", "run", "--no-supervise"]
