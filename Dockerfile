FROM ruby:3.2.2

ARG BUNDLER_VERSION

RUN apt-get update -qq \
&& apt-get install -y postgresql-client nodejs

ADD . /assessment

WORKDIR /assessment
RUN gem install bundler -v ${BUNDLER_VERSION}

COPY Gemfile* ./

WORKDIR /assessment
RUN bundle install
COPY . ./

# Use this to keep the app container running to allow for bootstrapping
CMD ["tail", "-f", "/dev/null"]