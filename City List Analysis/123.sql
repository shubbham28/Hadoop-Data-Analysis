ADD JAR /usr/lib/hive/lib/hive-serdes-1.0-SNAPSHOT.jar;
 ADD JAR /home/shubbham28/Downloads/Hadoop/flume1/jason-1.3.10-sources.jar;
 SET hive.support.sql11.reserved.keywords=false;
drop database if exists cities_info cascade;
create database cities_info;
use cities_info;
drop table if exists cities;
drop table if exists all_cities;
drop table if exists country_cities_count;
drop table if exists id;
drop table if exists countries;
drop table if exists country_cities;
 CREATE EXTERNAL TABLE cities (
    id INT,
    name STRING,
    country STRING,
   coord STRUCT<
	lon: DOUBLE,       
	lat: DOUBLE>
       
 )ROW FORMAT SERDE 'com.cloudera.hive.serde.JSONSerDe'
 LOCATION '/home/shubbham28/Downloads/city.list2.json';
load data local inpath '/home/shubbham28/Downloads/city.list1.json' OVERWRITE INTO TABLE cities;
create table all_cities as select id, name , country from cities order by id;
create table country_cities_count as select country, COUNT(*) from cities group by country order by country;
create table id as select id from cities order by id;
create table countries as select distinct country from cities order by country;
create table country_cities as select country, id from cities order by id;
create database country_wise_cities;

