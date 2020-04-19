import cx_Oracle

username = 'Maya'
password = 'Maya'
databaseName = 'localhost/xe'

connection = cx_Oracle.connect(username, password, databaseName)
cursor = connection.cursor()

print('Запит 1 - вивести назву гри і суму продажів')

query = '''SELECT
    game_name,
    SUM(to_number(sales, '9999.99')) AS suma
FROM
    sales
GROUP BY
    game_name'''

cursor.execute(query)
print('|game_name                                                                       |suma')
print('-' * 90)

row = cursor.fetchone()
while row:
    print("|{:80s}|{}".format(row[0], row[1]))
    row = cursor.fetchone()

print()



print('Запит 2 - Вивести жанр та % його популярності відносно інших жанрів.')

query = '''
SELECT
    genre_name,
    ROUND((SUM(to_number(sales, '9999.99')))*100/(SELECT SUM(to_number(sales, '9999.99')) FROM sales),2) AS percent
FROM
    (SELECT *
        FROM game
            INNER JOIN sales ON game.game_name = sales.game_name)
GROUP BY genre_name'''

cursor.execute(query)
print('|genre_name                              |percent')
print('-' * 50)

row = cursor.fetchone()
while row:
    print("|{:40s}|{}".format(row[0], row[1]))
    row = cursor.fetchone()

print()



print('Запит 3-Вивести динаміку продажів по компаніям.')

query = '''
SELECT
    publisher_name,
    SUM(to_number(sales, '9999.99')) AS suma
FROM
    (SELECT *
     FROM game
         INNER JOIN sales ON game.game_name = sales.game_name)
GROUP BY publisher_name
ORDER BY suma DESC'''

cursor.execute(query)
print('|publisher_name                          |suma')
print('-' * 50)

row = cursor.fetchone()
while row:
    print("|{:40s}|{}".format(row[0], row[1]))
    row = cursor.fetchone()

print()

connection.close()
