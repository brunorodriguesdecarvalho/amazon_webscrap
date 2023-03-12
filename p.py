import webbrowser
import requests
from bs4 import BeautifulSoup

url = 'https://www.amazon.com/s?k=iphone'

#webbrowser.open(url)

html_string = requests.get(url).content
soup = BeautifulSoup(html_string, 'html.parser')
soup.find_all('span')
