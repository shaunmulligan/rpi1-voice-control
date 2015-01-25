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

RUN wget https://m2m-aligner.googlecode.com/files/m2m-aligner-1.2.tar.gz && \
	tar -xvf m2m-aligner-1.2.tar.gz && \
	cd m2m-aligner-1.2/ && \
	make

RUN wget https://mitlm.googlecode.com/files/mitlm-0.4.1.tar.gz && \
	tar -xvf mitlm-0.4.1.tar.gz && \
	cd mitlm-0.4.1/ && \
	./configure && \
	make install

RUN cp /m2m-aligner-1.2/m2m-aligner /usr/local/bin/m2m-aligner

RUN wget http://distfiles.macports.org/openfst/openfst-1.3.3.tar.gz &&\
	tar -xvf openfst-1.3.3.tar.gz && \
	cd openfst-1.3.3/ && \
	./configure --enable-compact-fsts --enable-const-fsts --enable-far --enable-lookahead-fsts --enable-pdt && \
	make install

RUN wget https://phonetisaurus.googlecode.com/files/phonetisaurus-0.7.8.tgz && \
	tar -xvf phonetisaurus-0.7.8.tgz && \
	cd phonetisaurus-0.7.8/ && \
	cd src && \
	make


RUN cp /phonetisaurus-0.7.8/phonetisaurus-g2p /usr/local/bin/phonetisaurus-g2p

RUN wget http://phonetisaurus.googlecode.com/files/g014b2b.tgz && \
	tar -xvf g014b2b.tgz && \
	cd g014b2b/ && \
	./compile-fst.sh && \
	cd .. && \
	mv ~/g014b2b ~/phonetisaurus

# ADD . /app

# CMD python /app/main.py