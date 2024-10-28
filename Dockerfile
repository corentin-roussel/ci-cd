FROM scratch
WORKDIR ./
COPY hello .
CMD ["/hello"]
