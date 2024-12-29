import json
import mysql.connector


def carregar_json(arquivo):
    with open(arquivo, 'r') as file:
        return json.load(file)


def conectar_mysql():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="password",
        database="mobiledictionary"
    )


def inserir_dados_no_mysql(dados_json):
    conn = conectar_mysql()
    cursor = conn.cursor()

    for chave, valor in dados_json.items():
        query = """
        INSERT INTO dicionario (chave, valor)
        VALUES (%s, %s)
        """
        cursor.execute(query, (chave, valor))

    conn.commit()
    cursor.close()
    conn.close()


arquivo_json = 'words_dictionary.json'

dados_json = carregar_json(arquivo_json)

inserir_dados_no_mysql(dados_json)
