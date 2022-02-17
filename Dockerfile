FROM epitechcontent/epitest-docker
COPY src/ .
COPY Makefile .
RUN make
CMD ["make", "tests_run"]