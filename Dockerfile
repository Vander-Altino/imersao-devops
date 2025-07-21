# Usa uma imagem oficial do Python como imagem base.
# A versão 'slim' é um bom equilíbrio entre tamanho e compatibilidade,
# sendo uma ótima alternativa à 'alpine' para evitar possíveis problemas com pacotes.
FROM python:3.13.4-alpine3.22

# Define o diretório de trabalho dentro do contêiner.
WORKDIR /app

# Copia o arquivo de dependências primeiro para aproveitar o cache de layers do Docker.
COPY requirements.txt .
# Instala as dependências listadas no requirements.txt.
RUN pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho.
COPY . .

# Expõe a porta 8000 para permitir a comunicação com a aplicação de fora do contêiner.
EXPOSE 8000

# Define o comando para executar a aplicação quando o contêiner iniciar.
# Usa 0.0.0.0 para tornar a aplicação acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000" , "--reload"]