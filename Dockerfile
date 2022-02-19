FROM epitechcontent/epitest-docker
COPY . .
CMD ["make", "tests_run"]