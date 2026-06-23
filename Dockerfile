FROM docker.io/nousresearch/hermes-agent:v2026.6.5

COPY --chmod=0755 entrypoint.sh /usr/local/bin/hermes-wrapper-entrypoint

ENTRYPOINT []
CMD ["/usr/local/bin/hermes-wrapper-entrypoint"]
