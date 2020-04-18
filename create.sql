/*усі дані з csv файлу були автоматично вивантажені в таблицю ps4*/
DELETE 
from ps4
where publisher IS NULL;

/*створення таблиці Genre і заповнення її унікальними значеннями*/
CREATE TABLE Genre(
  genre_name VARCHAR2(30) NOT NULL
);

ALTER TABLE  Genre
  ADD CONSTRAINT genre_pk PRIMARY KEY (genre_name);

INSERT INTO  Genre(genre_name)
SELECT DISTINCT genre FROM PS4;


/*створення таблиці Publisher і заповнення її унікальними значеннями*/
CREATE TABLE Publisher(
  publisher_name VARCHAR2(128) NOT NULL
);

ALTER TABLE  Publisher
  ADD CONSTRAINT publisher_pk PRIMARY KEY (publisher_name);

INSERT INTO  Publisher(publisher_name)
SELECT DISTINCT publisher FROM PS4;


/*створення таблиці Region і заповнення її унікальними значеннями*/
CREATE TABLE Region(
  region_name VARCHAR2(30) NOT NULL
);

ALTER TABLE  Region
  ADD CONSTRAINT region_pk PRIMARY KEY (region_name);
  
INSERT INTO Region(region_name) VALUES ('North_America');
INSERT INTO Region(region_name) VALUES ('Europe');
INSERT INTO Region(region_name) VALUES ('Japan');
INSERT INTO Region(region_name) VALUES ('Rest_of_world');


/*створення таблиці Game і заповнення її унікальними значеннями*/
CREATE TABLE Game(
  game_name VARCHAR2(128) NOT NULL,
  year VARCHAR2(30) NOT NULL,
  genre_name_fk VARCHAR2(30) NOT NULL,
  publisher_name_fk VARCHAR(128) NOT NULL
);

ALTER TABLE  Game
  ADD CONSTRAINT game_pk PRIMARY KEY (game_name,year);
  
ALTER TABLE  Game
  ADD CONSTRAINT games_fk FOREIGN KEY (game_name) REFERENCES Names (names);
  
ALTER TABLE  Game
  ADD CONSTRAINT genre_fk FOREIGN KEY (genre_name_fk) REFERENCES Genre (genre_name);
  
ALTER TABLE  Game
  ADD CONSTRAINT publisher_fk FOREIGN KEY (publisher_name_fk) REFERENCES Publisher (publisher_name);

INSERT INTO  Game(game_name,year,genre_name_fk,publisher_name_fk)
SELECT game,year,genre,publisher FROM PS4;


/*створення таблиці Names і заповнення її унікальними значеннями*/
CREATE TABLE Names(
  names VARCHAR2(128) NOT NULL
);

ALTER TABLE  Names
  ADD CONSTRAINT names_pk PRIMARY KEY (names);
  
INSERT INTO  Names(names)
SELECT DISTINCT game FROM PS4;


/*створення таблиці Sales */
CREATE TABLE Sales(
  game_name_fk VARCHAR2(128) NOT NULL,
  region_name_fk VARCHAR2(30) NOT NULL,
  sales VARCHAR2(30) NOT NULL
);

ALTER TABLE  Sales
  ADD CONSTRAINT sales_pk PRIMARY KEY (game_name_fk,region_name_fk);
  
ALTER TABLE  Sales
  ADD CONSTRAINT game_fk FOREIGN KEY (game_name_fk) REFERENCES Names (names);
  
ALTER TABLE  Sales
  ADD CONSTRAINT region_fk FOREIGN KEY (region_name_fk) REFERENCES Region (region_name);
  
/*заповнення даними таблиці Sales*/
INSERT INTO Sales(game_name_fk,region_name_fk,sales) SELECT ps4.game, 'North_America',ps4.north_america
FROM ps4;

INSERT INTO Sales(game_name_fk,region_name_fk,sales) SELECT ps4.game, 'Europe',ps4.europe
FROM ps4;

INSERT INTO Sales(game_name_fk,region_name_fk,sales) SELECT ps4.game, 'Japan',ps4.japan
FROM ps4;

INSERT INTO Sales(game_name_fk,region_name_fk,sales) SELECT ps4.game, 'Rest_of_world',ps4.rest_of_world
FROM ps4;





