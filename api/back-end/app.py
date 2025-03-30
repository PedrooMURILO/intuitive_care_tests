from flask import Flask, request, jsonify
import csv

app = Flask(__name__)

operadoras = []

try:
    with open('Relatorio_cadop.csv', mode='r', encoding='utf-8') as file:
        operadoras = list(csv.DictReader(file, delimiter=';'))
        print(operadoras[0])
except FileNotFoundError:
    print("Erro: Arquivo 'Relatorio_cadop.csv' não encontrado.")
except Exception as e:
    print(f"Erro ao ler o arquivo CSV: {e}")

if __name__ == '__main__':
    app.run(debug=True)