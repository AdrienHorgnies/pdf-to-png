FROM docker.io/library/python:3.13.2-alpine3.21

RUN pip install --no-cache-dir --upgrade pip 
RUN pip install --no-cache-dir PyMuPDF==1.25.4
COPY main.py /

WORKDIR /workdir
USER 1000

ENTRYPOINT [ "python", "/main.py" ]
CMD []
