/*ps4- all data from csv*/
DELETE 
from ps4
where publisher IS NULL;


/* Genre */
CREATE TABLE Genre(
  genre_name VARCHAR2(30) NOT NULL
);

ALTER TABLE  Genre
  ADD CONSTRAINT genre_pk PRIMARY KEY (genre_name);
  

/* Publisher */
CREATE TABLE Publisher(
  publisher_name VARCHAR2(128) NOT NULL
);

ALTER TABLE  Publisher
  ADD CONSTRAINT publisher_pk PRIMARY KEY (publisher_name);
  
  
/* Region */
CREATE TABLE Region(
  region_name VARCHAR2(30) NOT NULL
);

ALTER TABLE  Region
  ADD CONSTRAINT region_pk PRIMARY KEY (region_name);
  

/* Game */
CREATE TABLE Game(
  game_name VARCHAR2(128) NOT NULL,
  year VARCHAR2(30) NOT NULL,
  genre_name VARCHAR2(30) NOT NULL,
  publisher_name VARCHAR(128) NOT NULL
);

ALTER TABLE  Game
  ADD CONSTRAINT game_pk PRIMARY KEY (game_name);
  
ALTER TABLE  Game
  ADD CONSTRAINT genre_fk FOREIGN KEY (genre_name) REFERENCES Genre (genre_name);
  
ALTER TABLE  Game
  ADD CONSTRAINT publisher_fk FOREIGN KEY (publisher_name) REFERENCES Publisher (publisher_name);
  

/* Sales */
CREATE TABLE Sales(
  game_name VARCHAR2(128) NOT NULL,
  region_name VARCHAR2(30) NOT NULL,
  sales VARCHAR2(30) NOT NULL
);

ALTER TABLE  Sales
  ADD CONSTRAINT sales_pk PRIMARY KEY (game_name,region_name);
  
ALTER TABLE  Sales
  ADD CONSTRAINT game_fk FOREIGN KEY (game_name) REFERENCES Game (game_name);
  
ALTER TABLE  Sales
  ADD CONSTRAINT region_fk FOREIGN KEY (region_name) REFERENCES Region (region_name);