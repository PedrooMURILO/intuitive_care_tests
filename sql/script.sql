CREATE DATABASE gestao_operadoras;
USE gestao_operadoras;

-- Queries para estruturar as tabelas
    CREATE TABLE operadoras_ativas_na_ans (
        id INT AUTO_INCREMENT PRIMARY KEY,
        Registro_ANS VARCHAR(6) NOT NULL,
        CNPJ VARCHAR(14) NOT NULL,
        Razao_Social VARCHAR(255) NOT NULL,
        Nome_Fantasia VARCHAR(255),
        Modalidade VARCHAR(100) NOT NULL,
        Logradouro VARCHAR(255) NOT NULL,
        Numero VARCHAR(20),
        Complemento VARCHAR(100),
        Bairro VARCHAR(100) NOT NULL,
        Cidade VARCHAR(100) NOT NULL,
        UF CHAR(2) NOT NULL,
        CEP VARCHAR(8),
        DDD VARCHAR(2),
        Telefone VARCHAR(20),
        Fax VARCHAR(20),
        Endereco_eletronico VARCHAR(100),
        Representante VARCHAR(255),
        Cargo_Representante VARCHAR(100),
        Regiao_de_Comercializacao INT DEFAULT 0,
        Data_Registro_ANS DATE NOT NULL,

        UNIQUE KEY(Registro_ANS),
        UNIQUE KEY(CNPJ),

        INDEX idx_modalidade (Modalidade),
        INDEX idx_uf (UF),
        INDEX idx_regiao (Regiao_de_Comercializacao)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

    CREATE TABLE demonstracoes_contabeis (
        id INT AUTO_INCREMENT PRIMARY KEY,
        DATA DATE NOT NULL,
        REG_ANS VARCHAR(6) NOT NULL,
        CD_CONTA_CONTABIL VARCHAR(20) NOT NULL,
        DESCRICAO VARCHAR(255) NOT NULL,
        VL_SALDO_INICIAL DECIMAL(15,2) NOT NULL,
        VL_SALDO_FINAL DECIMAL(15,2) NOT NULL,

        INDEX idx_data (DATA),
        INDEX idx_reg_ans (REG_ANS),
        INDEX idx_conta_contabil (CD_CONTA_CONTABIL)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Queries para importar dados
    LOAD DATA INFILE 'C:/xampp/IntuitiveCare/Relatorio_cadop.csv' -- AJUSTAR
    INTO TABLE operadoras_ativas_na_ans
    CHARACTER SET utf8mb4
    FIELDS TERMINATED BY ';'
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
        (Registro_ANS, CNPJ, Razao_Social, Nome_Fantasia, Modalidade, Logradouro, Numero, Complemento, Bairro, Cidade, UF, CEP, DDD, Telefone, Fax, Endereco_eletronico, Representante, Cargo_Representante, Regiao_de_Comercializacao, Data_Registro_ANS) 

    LOAD DATA INFILE 'C:/xampp/IntuitiveCare/1T2023.csv' -- AJUSTAR
    INTO TABLE demonstracoes_contabeis
    CHARACTER SET utf8mb4
    FIELDS TERMINATED BY ';' 
    ENCLOSED BY '"' 
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
        (DATA, REG_ANS, CD_CONTA_CONTABIL, DESCRICAO, VL_SALDO_INICIAL, VL_SALDO_FINAL);

    LOAD DATA INFILE 'C:/xampp/IntuitiveCare/1T2024.csv' -- AJUSTAR
    INTO TABLE demonstracoes_contabeis
    CHARACTER SET utf8mb4
    FIELDS TERMINATED BY ';' 
    ENCLOSED BY '"' 
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
        (DATA, REG_ANS, CD_CONTA_CONTABIL, DESCRICAO, VL_SALDO_INICIAL, VL_SALDO_FINAL);

    LOAD DATA INFILE 'C:/xampp/IntuitiveCare/2t2023.csv' -- AJUSTAR
    INTO TABLE demonstracoes_contabeis
    CHARACTER SET utf8mb4
    FIELDS TERMINATED BY ';' 
    ENCLOSED BY '"' 
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
        (DATA, REG_ANS, CD_CONTA_CONTABIL, DESCRICAO, VL_SALDO_INICIAL, VL_SALDO_FINAL);

    LOAD DATA INFILE 'C:/xampp/IntuitiveCare/2T2024.csv' -- AJUSTAR
    INTO TABLE demonstracoes_contabeis
    CHARACTER SET utf8mb4
    FIELDS TERMINATED BY ';' 
    ENCLOSED BY '"' 
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
        (DATA, REG_ANS, CD_CONTA_CONTABIL, DESCRICAO, VL_SALDO_INICIAL, VL_SALDO_FINAL);

    LOAD DATA INFILE 'C:/xampp/IntuitiveCare/3T2023.csv' -- AJUSTAR
    INTO TABLE demonstracoes_contabeis
    CHARACTER SET utf8mb4
    FIELDS TERMINATED BY ';' 
    ENCLOSED BY '"' 
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
        (DATA, REG_ANS, CD_CONTA_CONTABIL, DESCRICAO, VL_SALDO_INICIAL, VL_SALDO_FINAL);

    LOAD DATA INFILE 'C:/xampp/IntuitiveCare/3T2024.csv' -- AJUSTAR
    INTO TABLE demonstracoes_contabeis
    CHARACTER SET utf8mb4
    FIELDS TERMINATED BY ';' 
    ENCLOSED BY '"' 
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
        (DATA, REG_ANS, CD_CONTA_CONTABIL, DESCRICAO, VL_SALDO_INICIAL, VL_SALDO_FINAL);

    LOAD DATA INFILE 'C:/xampp/IntuitiveCare/4T2023.csv' -- AJUSTAR
    INTO TABLE demonstracoes_contabeis
    CHARACTER SET utf8mb4
    FIELDS TERMINATED BY ';' 
    ENCLOSED BY '"' 
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
        (DATA, REG_ANS, CD_CONTA_CONTABIL, DESCRICAO, VL_SALDO_INICIAL, VL_SALDO_FINAL);

    LOAD DATA INFILE 'C:/xampp/IntuitiveCare/4T2024.csv' -- AJUSTAR
    INTO TABLE demonstracoes_contabeis
    CHARACTER SET utf8mb4
    FIELDS TERMINATED BY ';' 
    ENCLOSED BY '"' 
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
        (DATA, REG_ANS, CD_CONTA_CONTABIL, DESCRICAO, VL_SALDO_INICIAL, VL_SALDO_FINAL);

-- Queries analíticas
    /* Quais as 10 operadoras com maiores despesas em 
    "EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR"
    no último trimestre? */
        SELECT 
            o.Razao_Social,
            o.Modalidade,
            o.UF,
            SUM(d.VL_SALDO_FINAL) AS total_despesas_anual,
            ROUND(SUM(d.VL_SALDO_FINAL) / 1000000, 2) AS total_milhoes
        FROM 
            Demonstracoes_Contabeis d
        JOIN 
            Operadoras_Ativas_na_ANS o ON d.REG_ANS = o.Registro_ANS
        WHERE 
            d.DESCRICAO LIKE '%EVENTOS/%SINISTROS%MEDICO HOSPITALAR%'
            AND d.DATA BETWEEN '2024-10-01' AND '2024-12-31'
        GROUP BY 
            o.Razao_Social, o.Modalidade, o.UF
        ORDER BY 
            total_despesas_anual DESC
        LIMIT 10;

    /* Quais as 10 operadoras com maiores despesas nessa categoria no último ano? */
        SELECT 
            o.Razao_Social,
            o.Modalidade,
            o.UF,
            SUM(d.VL_SALDO_FINAL) AS total_despesas_anual,
            ROUND(SUM(d.VL_SALDO_FINAL) / 1000000, 2) AS total_milhoes
        FROM 
            Demonstracoes_Contabeis d
        JOIN 
            Operadoras_Ativas_na_ANS o ON d.REG_ANS = o.Registro_ANS
        WHERE 
            d.DATA BETWEEN '2024-01-01' AND '2024-12-31'
            AND d.DESCRICAO LIKE '%EVENTOS/%SINISTROS%MEDICO HOSPITALAR%' 
        GROUP BY 
            o.Razao_Social, o.Modalidade, o.UF
        ORDER BY 
            total_despesas_anual DESC
        LIMIT 10;