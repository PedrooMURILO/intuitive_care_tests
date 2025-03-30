from flask import Flask, request, jsonify
import csv

app = Flask(__name__)

operadoras = []

try:
    with open('Relatorio_cadop.csv', mode='r', encoding='utf-8') as file:
        operadoras = list(csv.DictReader(file, delimiter=';'))
except FileNotFoundError:
    print("Erro: Arquivo 'Relatorio_cadop.csv' não encontrado.")
except Exception as e:
    print(f"Erro ao ler o arquivo CSV: {e}")
    
    
def buscar_operadoras(query):
    resultados = []
    
    query = query.lower()
    
    for op in operadoras:
        if (query in op['Razao_Social'].lower()) or (query in op['Nome_Fantasia'].lower()):
            resultados.append(op)
    
    return resultados

print(buscar_operadoras("administradora")[0])

if __name__ == '__main__':
    app.run(debug=True)