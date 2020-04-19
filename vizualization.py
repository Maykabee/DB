import re
import chart_studio
import cx_Oracle
import chart_studio.plotly as py
import plotly.graph_objs as go
import chart_studio.dashboard_objs as dashboard

chart_studio.tools.set_credentials_file(username='Mayvelin', api_key='B0Ey49WM2WnfCQR4IjDC')

username = 'Maya'
password = 'Maya'
databaseName = 'localhost/xe'

connection = cx_Oracle.connect(username, password, databaseName)
cursor = connection.cursor()

#Запит 1 - вивести топ-15 ігор та суму їх продажів

query = '''
SELECT *
FROM(
SELECT
    game_name,
    SUM(to_number(sales, '9999.99')) AS suma
FROM
    sales
GROUP BY
    game_name
ORDER BY suma DESC)
WHERE ROWNUM<=15'''

cursor.execute(query)
game_name = []
suma = []

row = cursor.fetchone()
while row:
    game_name.append(row[0])
    suma.append(row[1])
    row = cursor.fetchone()

bar = [go.Bar(
    x=game_name,
    y=suma
)]
layout = go.Layout(
    xaxis={
        'title': "Game's name"
    },
    yaxis={
        'title': 'Global sales'
    }
)

fig = go.Figure(data=bar, layout=layout)

url_1 = py.plot(fig, filename='Global sales ')

#Запит 2 - Вивести жанр та % його популярності у порівнянні з іншими

query = '''
SELECT
    genre_name,
    ROUND((SUM(to_number(sales, '9999.99')))*100/(SELECT SUM(to_number(sales, '9999.99')) FROM sales),2) AS percent
FROM
    (SELECT *
        FROM game
            INNER JOIN sales ON game.game_name = sales.game_name)
GROUP BY
    genre_name
'''

cursor.execute(query)
genre_name = []
percent = []

row = cursor.fetchone()
while row:
    genre_name.append(row[0])
    percent.append(row[1])
    row = cursor.fetchone()

pie = go.Pie(labels=genre_name, values=percent)
url_2 = py.plot([pie], filename="Genre's percent")

#Запит 3 - вивести динаміку продажів ігор кожною компанією

query = '''
SELECT
    publisher_name,
    SUM(to_number(sales, '9999.99')) AS suma
FROM
    (SELECT *
     FROM game
         INNER JOIN sales ON game.game_name = sales.game_name)
GROUP BY
    publisher_name
'''

cursor.execute(query)
publisher_name = []
suma = []

row = cursor.fetchone()
while row:
    publisher_name.append(row[0])
    suma.append(row[1])
    row = cursor.fetchone()

scatter = go.Scatter(
    x=publisher_name,
    y=suma,
    mode='lines+markers'
)
url_3 = py.plot([scatter], filename="Publisher's sales")

connection.close()

# ----------------------------------------------------
# dashboard time!
board = dashboard.Dashboard()
board.get_preview()


def fileId_from_url(url):
    """Return fileId from a url."""
    raw_fileId = re.findall("~[A-z.]+/[0-9]+", url)[0][1:]
    return raw_fileId.replace('/', ':')


box_1 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': fileId_from_url(url_1),
    'title': "Game's lobal sales "
}
box_2 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': fileId_from_url(url_2),
    'title': "Genre's percent"
}
box_3 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': fileId_from_url(url_3),
    'title': "Publisher's percent"
}

board.insert(box_1)
board.insert(box_3, 'below', 1)
board.insert(box_2, 'right', 2)
board.get_preview()

py.dashboard_ops.upload(board, 'Games for PS4')
