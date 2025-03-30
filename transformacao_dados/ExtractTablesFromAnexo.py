import tabula

pdf_file = "Anexo_I_Rol_2021RN_465.2021_RN627L.2024.pdf"

tables = tabula.read_pdf(pdf_file, pages="3-181", multiple_tables=True, lattice=True)

print(tables[0])