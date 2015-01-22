FROM resin/rpi-raspbian:wheezy-2015-01-15

# Install Python.
RUN apt-get update && apt-get install -y git-core wget python-dev python-pip bison libasound2-dev libportaudio-dev python-pyaudio
RUN wget http://downloads.sourceforge.net/project/cmusphinx/sphinxbase/0.8/sphinxbase-0.8.tar.gz && \
tar -zxvf sphinxbase-0.8.tar.gz 
RUN cd /sphinxbase-0.8 && \
./configure --enable-fixed && \
make && \
make install
RUN wget http://downloads.sourceforge.net/project/cmusphinx/pocketsphinx/0.8/pocketsphinx-0.8.tar.gz && \
tar -zxvf pocketsphinx-0.8.tar.gz && \ 
ls && \
cd pocketsphinx-0.8 && \
./configure && \
make && \
make install

RUN apt-get install -y subversion autoconf libtool automake gfortran g++
RUN svn co https://svn.code.sf.net/p/cmusphinx/code/trunk/cmuclmtk/ && \
	cd cmuclmtk/ && \
	./autogen.sh && make && make install && \
	cd ..

RUN echo 'deb http://ftp.debian.org/debian experimental main contrib non-free' > /etc/apt/sources.list.d/experimental.list && \
	apt-get update && \
	apt-get -t experimental install phonetisaurus m2m-aligner mitlm openfst

RUN wget http://phonetisaurus.googlecode.com/files/g014b2b.tgz && \
	tar -xvf g014b2b.tgz && \
	cd g014b2b/ && \
	./compile-fst.sh && \
	cd .. && \
	mv ~/g014b2b ~/phonetisaurus
ADD . /app

CMD python /app/main.py