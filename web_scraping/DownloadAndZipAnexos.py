import requests
from bs4 import BeautifulSoup
from urllib.parse import urljoin

url = "https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos"

response = requests.get(url)

if response.status_code == 200:
    soup = BeautifulSoup(response.text, "html.parser")
    
    links = soup.find_all("a", href=True)
    
    pdf_links = [urljoin(url, link["href"]) for link in links if "anexo" in link["href"].lower() and link["href"].lower().endswith(".pdf")]
    
    print(pdf_links)
else:
    print("Erro ao acessar o site.")