 /* Запит 1- Вивести назву гри і загальну суму продажів.*/
SELECT
    game_name,
    SUM(to_number(sales, '9999.99')) AS suma
FROM
    sales
GROUP BY
    game_name;

/*Запит 2- Вивести жанр та % його популярності відносно інших жанрів.*/
SELECT
    genre_name,
    ROUND((SUM(to_number(sales, '9999.99')))*100/(SELECT SUM(to_number(sales, '9999.99')) FROM sales),2) AS percent
FROM
    (SELECT *
        FROM game
            INNER JOIN sales ON game.game_name = sales.game_name)
GROUP BY
    genre_name;  
    
    
/*Запит 3-Вивести динаміку продажів по компаніям.*/
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
    
