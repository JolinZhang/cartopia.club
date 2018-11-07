docker run \
-d \
--name cartopia \
--network GoldenArches \
-v `pwd`/:/cartopia.club/ \
-w /cartopia.club \
shaneqi/cartopia:latest \
/bin/sh -c \
"\
bundle install;\
bin/rake db:migrate RAILS_ENV=development;\
rm /cartopia.club/tmp/pids/server.pid;\
rails server -b 0.0.0.0;\
"
