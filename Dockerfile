FROM epitechcontent/epitest-docker
COPY . .
COPY Makefile .
RUN make
CMD ["make", "tests_run"]