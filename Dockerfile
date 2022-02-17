FROM epitechcontent/epitest-docker
COPY . .
RUN make
CMD ["make", "tests_run"]