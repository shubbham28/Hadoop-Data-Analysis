-- created a  seperate database
  create database stock1;

  use stock1;
-- creating tables and loading csv file in it
  create table csv(col STRING);

  Load data local inpath '/home/shubbham28/Downloads/aapl.csv' overwrite into table csv;

  create table apple(date_ string,open float,high float,low float,close float,volume float);
  
  insert overwrite table apple select regexp_extract(col,'^(?:([^,]*)\,?){1}',0) date_,regexp_extract(col,'^(?:([^,]*)\,?){2}',1) open,regexp_extract(col,'^(?:([^,]*)\,?){3}',1) high,regexp_extract(col,'^(?:([^,]*)\,?){4}',1) low,regexp_extract(col,'^(?:([^,]*)\,?){5}',1) close,regexp_extract(col,'^(?:([^,]*)\,?){6}',1) volume from csv;
 

-- show data of last two months   
  create table apple_jun_july as select * from apple where date_ Like'__-Ju_-17,';
-- show data when stock open at max
  create table apple_open_max as select * from apple where open >148.5 order by open desc;
-- show data when stock close at min
  create table apple_close_min as select * from apple where close<110.5 order by  close;
