##### PREREQUISITES

First run the generation of the transitive closure file, then test loading the files.

##### MySQL 5.6

#
# For testing mysql, run a docker mysql instance
#  - https://hub.docker.com/_/mysql

#
# Launch the container
#
docker run --name snomed-mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=admin -e MYSQL_DATABASE=snomed -d mysql:5.6

#
# populate_mysql_db.sh
# host = host.docker.internal  (**make sure to edit this setting before proceeding)
#
dir=c:/data/SnomedCt_International
docker run -it -v $dir:/data mysql:5.6 /bin/bash
root@842bfb3da1f1:/# cd /data
root@842bfb3da1f1:/data# ./populate_mysql_db_tc.sh &


##### MySQL 5.7

#
# For testing mysql, run a docker mysql instance
#  - https://hub.docker.com/_/mysql

#
# Launch the container
#
docker run --name snomed-mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=admin -e MYSQL_DATABASE=snomed -d mysql:5.7

#
# populate_mysql_db.sh
# host = host.docker.internal  (**make sure to edit this setting before proceeding)
#
dir=c:/data/SnomedCt_International
docker run -it -v $dir:/data mysql:5.7 /bin/bash
root@842bfb3da1f1:/# cd /data
root@842bfb3da1f1:/data# ./populate_mysql_db.sh &

