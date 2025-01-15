FROM python:alpine

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt 
RUN pip install gunicorn

COPY . . 

EXPOSE 5000

CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:5000", "app:app"]