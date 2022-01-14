FROM python:3
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
RUN export $(cat .env | xargs) 
CMD [ "python3", "hello.py" ]