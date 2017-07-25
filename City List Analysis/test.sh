hive --f /home/shubbham28/Downloads/123.sql 
hive -e 'select country from cities_info.countries;' > list
tail -n +1 list | while IFS=' ' read -r country
do
hive -hiveconf code=$country -f cities.hql
done

