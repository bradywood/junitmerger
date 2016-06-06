FROM centos:centos7

MAINTAINER Brady Wood <bradyrwood@gmail.com>

RUN mkdir -p /run/lock \
    && yum -y install epel-release \
    && yum -y upgrade \
    && yum install -y \
        bc \
        initscripts \
        libaio \
        net-tools \
        python-pip \
        socat \
        stunnel \
        unzip \
        wget \
        less \
    && pip install pip --upgrade \
    && pip install supervisor \
    && yum -y clean all
    

RUN mkdir -p /usr/java \
    && cd /tmp \
    && curl -s -L -C - -b "oraclelicense=accept-securebackup-cookie" -O http://download.oracle.com/otn-pub/java/jdk/8u91-b14/jdk-8u91-linux-x64.tar.gz

ENV JAVA_HOME=/usr/java/jdk1.8.0_91 \
    PATH=${PATH}:/usr/java/jdk1.8.0_91/bin

#RUN curl -s -L -C - -b "oraclelicense=accept-securebackup-cookie" -O http://download.oracle.com/otn-pub/java/jdk/8u91-b14/jdk-8u91-linux-x64.tar.gz
#    && tar -zvfx jdk-8u91-linux-x64.tar.gz -C /usr/java \

RUN cd /tmp \
    && ls -l \
    && tar xvf jdk-8u91-linux-x64.tar.gz -C /usr/java \
    && cd ${JAVA_HOME}/jre/lib/ext \
    && ln -sf /usr/java/jdk1.8.0_91 /usr/java/default

RUN ln -sf ../usr/share/zoneinfo/Australia/Sydney /etc/localtime


#ADD .bash_profile /root/.bash_profile
ADD merge_junit_results.py /merge_junit_results.py
ADD nicelyFormattedJunit.xsl /nicelyFormattedJunit.xsl
ADD runReport.sh /runReport.sh

RUN chmod a+rwx /runReport.sh
RUN chmod a+rwx /merge_junit_results.py
RUN wget http://sourceforge.net/projects/saxon/files/latest/download?source=files -O /tmp/saxonhe9.zip

RUN cd /tmp \
  && unzip saxonhe9.zip \
  && chmod -R 777 /tmp/
  
ENV TERM xterm

CMD /runReport.sh
