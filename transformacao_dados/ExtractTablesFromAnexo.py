import tabula
import pandas as pd
import zipfile
import os

pdf_file = "Anexo_I_Rol_2021RN_465.2021_RN627L.2024.pdf"

def replace_abbreviations(df):
    df.replace({"OD": "Seg. Odontológica", "AMB": "Seg. Ambulatoria"}, inplace=True)
    return df

tables = tabula.read_pdf(pdf_file, pages="3-181", multiple_tables=True, lattice=True)

processed_tables = []
for table in tables:
    # Substituir abreviações
    table = replace_abbreviations(table)
    table.columns = table.columns.str.replace("\r", " ", regex=False)
    table = table.map(lambda x: str(x).replace("\r", " "))
    processed_tables.append(table)

final_table = pd.concat(processed_tables, ignore_index=True)

csv_file = "dados_extraidos.csv"
final_table.to_csv(csv_file, index=False, sep=';')

zip_file = "Teste_Pedro_Armindo.zip"
with zipfile.ZipFile(zip_file, 'w') as zipf:
    zipf.write(csv_file, os.path.basename(csv_file))

print(f"Arquivo CSV salvo e compactado em {zip_file}")