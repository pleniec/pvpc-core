FROM ruby:2.2.2

COPY . /opt/pvpc-core
WORKDIR /opt/pvpc-core

ENV RAILS_ENV vagrant

RUN bundle install

EXPOSE 3000

CMD ["rails", "s", "-b", "0.0.0.0"]
