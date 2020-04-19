/* First*/
SELECT
    game_name,
    SUM(to_number(sales, '9999.99')) AS suma
FROM
    sales
GROUP BY
    game_name;


/*Second*/
SELECT
    genre_name,
    SUM(to_number(sales, '9999.99')) AS suma
FROM
    (SELECT *
        FROM game
            INNER JOIN sales ON game.game_name = sales.game_name)
GROUP BY
    genre_name;


    
SELECT
    SUM(suma) AS total_suma
FROM
    (SELECT
            genre_name,
            SUM(to_number(sales, '9999.99')) AS suma
     FROM
            (SELECT *
                FROM
                    game
                    INNER JOIN sales ON game.game_name = sales.game_name)
                GROUP BY
                    genre_name); 
                    
                    
SELECT
    genre_name,
    ROUND((SUM(to_number(sales, '9999.99')))*100/595.36,2) AS suma
FROM
    (SELECT *
        FROM game
            INNER JOIN sales ON game.game_name = sales.game_name)
GROUP BY
    genre_name;
    

/*Third*/
SELECT
    publisher_name,
    SUM(to_number(sales, '9999.99')) AS suma
FROM
    (SELECT *
     FROM game
         INNER JOIN sales ON game.game_name = sales.game_name)
GROUP BY
    publisher_name
ORDER BY
    suma DESC;
                    

    


