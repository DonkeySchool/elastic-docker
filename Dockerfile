FROM elasticsearch:8.1.1

RUN bin/elasticsearch-plugin install analysis-icu 