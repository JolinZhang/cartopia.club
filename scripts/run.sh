docker run -p 3000:3000 -it -v `pwd`/:/cartopia.club/ ruby:2.3.0 sh -c \
"\
apt-get update;\
apt-get install nodejs -y;\
cd cartopia.club;\
bundle install;\
bin/rake db:migrate RAILS_ENV=development;\
rails server -b 0.0.0.0;\
"
