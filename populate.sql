/* Genre */

INSERT INTO  Genre(genre_name)
SELECT DISTINCT genre FROM PS4;
  

/* Publisher */

INSERT INTO  Publisher(publisher_name)
SELECT DISTINCT publisher FROM PS4;
  
  
/* Region */

INSERT INTO Region(region_name) VALUES ('North_America');
INSERT INTO Region(region_name) VALUES ('Europe');
INSERT INTO Region(region_name) VALUES ('Japan');
INSERT INTO Region(region_name) VALUES ('Rest_of_world');

  
/* Game */

INSERT INTO  Game(game_name,year,genre_name,publisher_name)
SELECT game,year,genre,publisher FROM PS4;

  

/* Sales */

INSERT INTO Sales(game_name,region_name,sales) SELECT ps4.game, 'North_America',ps4.north_america
FROM ps4;

INSERT INTO Sales(game_name,region_name,sales) SELECT ps4.game, 'Europe',ps4.europe
FROM ps4;

INSERT INTO Sales(game_name,region_name,sales) SELECT ps4.game, 'Japan',ps4.japan
FROM ps4;

INSERT INTO Sales(game_name,region_name,sales) SELECT ps4.game, 'Rest_of_world',ps4.rest_of_world
FROM ps4;
