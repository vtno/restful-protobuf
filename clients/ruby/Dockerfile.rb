FROM ruby:3.0
COPY . .
RUN bundle
CMD ["ruby", "main.rb"] 
