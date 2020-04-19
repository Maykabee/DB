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
    ROUND((SUM(to_number(sales, '9999.99')))*100/(SELECT SUM(to_number(sales, '9999.99')) FROM sales),2) AS percent
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
    
