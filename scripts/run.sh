SCRIPT=`readlink -f "$0"`
SCRIPTPATH=`dirname "$SCRIPT"`
PROJPATH=`dirname "$SCRIPTPATH"`
docker run \
-d \
--name cartopia \
-v $PROJPATH/:/cartopia.club/ \
-w /cartopia.club \
ruby:2.3.0 \
/bin/sh -c \
"\
apt-get update;\
apt-get install nodejs -y;\
bundle install;\
bin/rake db:migrate RAILS_ENV=development;\
rails server -b 0.0.0.0;\
"
