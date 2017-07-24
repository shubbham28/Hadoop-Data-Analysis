--load Pokemon.csv file in table format
Data = LOAD '/home/shubbham28/Downloads/Hadoop/analysis_file/Pokemon.csv' USING PigStorage(',') AS(Sno:int,Name:chararray,Type1:chararray,Type2:chararray,Total:int,HP:int,Attack:int,Defense:int,SpAtk:int,SpDef:int,Speed:int);

--Save Top 300 Pokemon 
top1= order Data by Total desc;
top300 = limit top1 300;
store top300 into '/home/shubbham28/Downloads/Pokemon_analysis/top300_pokemon';

--Save number of Pokemon whose defense is greater than 60	
selected_list = filter Data by Defense>60;
group_list = group selected_list by Type1;
count_list = FOREACH group_list GENERATE group , COUNT(selected_list);
store count_list into '/home/shubbham28/Downloads/Pokemon_analysis/Type_count_selected(def>60)';

--Save number of POkemon in each Type	
group_list= group Data by Type1;
count_list = FOREACH group_list GENERATE group,COUNT(Data);
store count_list into '/home/shubbham28/Downloads/Pokemon_analysis/Type_count';

--Save a list of all Fire Type Pokemon 
fire= filter Data by (Type1 MATCHES '.*Fire.*') or (Type2 MATCHES '.*Fire.*');
store fire into '/home/shubbham28/Downloads/Pokemon_analysis/Type_fire';

--Save a list of all Grass Type Pokemon 
fire= filter Data by (Type1 MATCHES '.*Grass.*') or (Type2 MATCHES '.*Grass.*');
store fire into '/home/shubbham28/Downloads/Pokemon_analysis/Type_Grass';

--Save a list of all Water Type Pokemon 
fire= filter Data by (Type1 MATCHES '.*Water.*') or (Type2 MATCHES '.*Water.*');
store fire into '/home/shubbham28/Downloads/Pokemon_analysis/Type_Water';

--Save a list of all Electric Type Pokemon 
fire= filter Data by (Type1 MATCHES '.*Electric.*') or (Type2 MATCHES '.*Electric.*');
store fire into '/home/shubbham28/Downloads/Pokemon_analysis/Type_Electric';

--Save a list of all Ground Type Pokemon 
fire= filter Data by (Type1 MATCHES '.*Ground.*') or (Type2 MATCHES '.*Ground.*');
store fire into '/home/shubbham28/Downloads/Pokemon_analysis/Type_Ground';

--Create a two random list of Pokemon and select top 10 frommboth of them for 2 player and save them in ordered manner
random = FOREACH Data GENERATE RANDOM(),Name,Type1,Type2,Total,HP,Attack,Defense,SpAtk,SpDef,Speed;
desc1= order random by $0 desc;
random = FOREACH Data GENERATE RANDOM(),Name,Type1,Type2,Total,HP,Attack,Defense,SpAtk,SpDef,Speed;
desc2= order random by $0 desc;
top_1 = limit desc1 10;
top_2 = limit desc2 10;
player1= FOREACH top_1 GENERATE $1,Total;
player2= FOREACH top_2 GENERATE $1,Total;
ordered= order player1 by Total desc;
store ordered into '/home/shubbham28/Downloads/Pokemon_analysis/Player_1_Pokemon';
ordered= order player2 by Total desc;
store ordered into '/home/shubbham28/Downloads/Pokemon_analysis/Player_2_Pokemon';

--Save Pokemon from both listin a union and arrange them
top = union player1,player2;
order_ = order top by Total desc;
store order_ into '/home/shubbham28/Downloads/Pokemon_analysis/players_ordered_pokemon';
 





