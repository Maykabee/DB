/*ps4-dataset*/
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
  

/*  Game */
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


/*  Names */
CREATE TABLE Names(
  names VARCHAR2(128) NOT NULL
);

ALTER TABLE  Names
  ADD CONSTRAINT names_pk PRIMARY KEY (names);
  

/* Sales */
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
