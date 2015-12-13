#!/bin/bash
case "$1" in
    start)
        TRUSTED_IP=0.0.0.0/16 rails s -b 0.0.0.0 Puma
        ;;
    migrate)
        rake db:migrate
        ;;
    compile)
        RAILS_ENV=development bundle exec rake assets:precompile
        ;;
    convert)
        rake haml:erb2haml
        ;;
    bower_install)
        rake bower:install:deployment
        ;;
    bower_update)
        rake bower:update
        ;;
    bower_list)
        rake bower:list
        ;;
    bower_cache_clean)
        rake bower:cache:clean
        ;;
    *)
        echo "Usage: $0 start|migrate|compile|convert|bower_install|bower_update|bower_list|bower_cache_clean"
        exit 1
esac
exit 0