FROM resin/rpi-raspbian:wheezy-2015-01-15

# Install Python.
RUN apt-get update && apt-get install -y git-core wget python-dev python-pip bison libasound2-dev libportaudio-dev python-pyaudio
RUN wget http://sourceforge.net/projects/cmusphinx/files/sphinxbase/0.8/sphinxbase-0.8.tar.gz/download
RUN tar -zxf download.tar.gz && cd  download
RUN ./configure --enable-fixed && make && make install


ADD . /app

CMD python /app/main.py