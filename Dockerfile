#Define la imagen base de nueva imagen.
FROM python:3.13.5-alpine3.22

#Establece el directorio de trabajo
WORKDIR /app

#Ahora, todas las operaciones se realizarán dentro de /app

#Copia el archivo desde el local a /app en la imagen
COPY requirements.txt .

#Instala las librerías en requirements.txt
#no guarde los paquetes descargados en una caché
#mantiene el tamaño de la imagen chica
RUN pip install --no-cache-dir -r requirements.txt

#Copia el resto del código fuente
COPY . .

#Informa que el contenedor escuchará el puerto
EXPOSE 8000

#correr la aplicación con uvicorn
#host 0.0.0.0 lo hace accesible externo del contenedor
#Uvicorn reinicie el servidor al haber un cambio en código
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]

#para construir "docker build -t api ."