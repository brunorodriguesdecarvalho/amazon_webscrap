from selectorlib import Extractor
import requests 
import json 
from time import sleep
import webbrowser

#Abre a página e digita ipone na busca
url = 'https://www.amazon.com/s?k=iphone'
webbrowser.open(url)

#Cria um Extrator ao ler a estrutura que está no arquivo YAML referenciado a seguir
e = Extractor.from_yaml_file('search_results.yml')

def scrape(url):  

    headers = {
        'dnt': '1',
        'upgrade-insecure-requests': '1',
        'user-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.61 Safari/537.36',
        'accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9',
        'sec-fetch-site': 'same-origin',
        'sec-fetch-mode': 'navigate',
        'sec-fetch-user': '?1',
        'sec-fetch-dest': 'document',
        'referer': 'https://www.amazon.com/',
        'accept-language': 'en-GB,en-US;q=0.9,en;q=0.8',
    }

    #Faz a requisição de download da página
    print("               Baixando dados da pesquisa de: %s"%url)
    r = requests.get(url, headers=headers)
    #Teste simples para checar se a página está bloqueada
    if r.status_code > 500:
        if "To discuss automated access to Amazon data please contact" in r.text:
            print("               A página %s foi bloqueada pela Amazon. Por favor tente utilizando outro Proxy\n"%url)
        else:
            print("               A página %s deve ter sido bloqueada pela Amazon com o código de status %d"%(url,r.status_code))
        return None
    #Pega o HTML e cria o arquivo
    return e.extract(r.text)

with open("search_results_urls.txt",'r') as urllist, open('search_results_output.jsonl','w') as outfile:
    for url in urllist.read().splitlines():
        data = scrape(url) 
        if data:
            for product in data['products']:
                product['search_url'] = url
                print("               Salvando produto: %s"%product['title'])
                json.dump(product,outfile)
                outfile.write("\n")
                # sleep(5) caso seja necessário ajustar o scraper por consideração ao tempo.
    
