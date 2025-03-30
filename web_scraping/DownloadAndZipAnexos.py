import requests
from bs4 import BeautifulSoup
from urllib.parse import urljoin
import os

url = "https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos"

os.makedirs("downloads", exist_ok=True)

response = requests.get(url)

if response.status_code == 200:
    soup = BeautifulSoup(response.text, "html.parser")
    
    links = soup.find_all("a", href=True)
    
    pdf_links = [urljoin(url, link["href"]) for link in links if "anexo" in link["href"].lower() and link["href"].lower().endswith(".pdf")]
    
    downloaded_files = []
    for link in pdf_links:
        file_name = link.split("/")[-1]
        file_path = os.path.join("downloads", file_name)
        pdf_response = requests.get(link, stream=True)
        if pdf_response.status_code == 200:
            with open(file_path, "wb") as file:
                for chunk in pdf_response.iter_content(1024):
                    file.write(chunk)
            print(f"Download concluído: {file_path}")
            downloaded_files.append(file_path)
        else:
            print(f"Erro ao baixar: {link}")
else:
    print("Erro ao acessar o site.")