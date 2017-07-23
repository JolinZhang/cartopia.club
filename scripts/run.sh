docker run \
-d \
--name cartopia \
-p 3000:3000 \
-v `pwd`/:/cartopia.club/ \
-w /cartopia.club \
ruby:2.3.0 \
sh -c \
"\
apt-get update;\
apt-get install nodejs -y;\
bundle install;\
bin/rake db:migrate RAILS_ENV=development;\
rails server -b 0.0.0.0;\
"
