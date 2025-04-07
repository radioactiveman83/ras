import requests
from bs4 import BeautifulSoup
import os

def download_docker_compose(base_url):
    response = requests.get(base_url)
    soup = BeautifulSoup(response.text, 'html.parser')

    # Erstellen des Verzeichnisses für die Docker Compose Dateien
    os.makedirs('docker-compose-files', exist_ok=True)

    # Extrahiere alle relevanten Links
    links = soup.find_all('a', href=True)
    docker_links = [link['href'] for link in links if 'docker-' in link['href']]

    for link in docker_links:
        full_url = f"https://docs.linuxserver.io{link}"
        page_response = requests.get(full_url)
        page_soup = BeautifulSoup(page_response.text, 'html.parser')

        # Finde den Abschnitt mit der Docker Compose YAML
        code_blocks = page_soup.find_all('code')
        docker_compose = next((block for block in code_blocks if 'version:' in block.text), None)

        if docker_compose:
            # Bestimme den Namen des Containers aus dem URL-Pfad
            container_name = link.split('/')[-1]
            file_path = f"docker-compose-files/{container_name}.yaml"

            # Speichere die Docker Compose Datei
            with open(file_path, 'w') as file:
                file.write(docker_compose.text)
            print(f"Docker-compose für {container_name} gespeichert als {file_path}")

if __name__ == "__main__":
    base_url = "https://docs.linuxserver.io/images-by-category/"
    download_docker_compose(base_url)
