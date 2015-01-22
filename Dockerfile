FROM resin/rpi-raspbian:wheezy-2015-01-15

# Install Python.
RUN apt-get update && apt-get install -y git-core python-dev python-pip bison libasound2-dev libportaudio-dev python-pyaudio pocketsphinx



ADD . /app

CMD python /app/main.py