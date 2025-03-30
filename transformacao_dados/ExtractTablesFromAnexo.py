import tabula
import pandas as pd

pdf_file = "Anexo_I_Rol_2021RN_465.2021_RN627L.2024.pdf"

tables = tabula.read_pdf(pdf_file, pages="3-181", multiple_tables=True, lattice=True)

final_table = pd.concat(tables, ignore_index=True)

csv_file = "dados_extraidos.csv"

final_table.to_csv(csv_file, index=False, sep=';')