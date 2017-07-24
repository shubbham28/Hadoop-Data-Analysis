--load msft file in table format
csv =LOAD '/home/shubbham28/Downloads/msft.csv' using PigStorage(',') as (date_:chararray,open:float,high:float,low:float,close:float,volume:float);
-- save data of last two months   
msft= filter csv by (date_ matches '.*Ju.*') and (date_ matches '.*17.*');

store msft into '/home/shubbham28/Downloads/Stock/msft_jun_july';
-- save data when stock open at max
msft = filter csv by open>70.5;

msft1 = order msft by open desc;

store msft1 into'/home/shubbham28/Downloads/Stock/msft_open_max';
-- save data when stock close at min
msft = filter csv by close<63.5;

msft1 = order msft by close asc;

store msft1 into'/home/shubbham28/Downloads/Stock/msft_close_min';



