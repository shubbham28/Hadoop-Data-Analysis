SET hive.support.sql11.reserved.keywords=false;
use country_wise_cities;
create table ${hiveconf:code} as Select * from all_cities where country = '${hiveconf:code}' order by id;
