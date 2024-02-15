FROM openjdk:10-jdk

# 환경 변수 및 작업 경로
ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
RUN mkdir -p "$CATALINA_HOME"
WORKDIR ${CATALINA_HOME}

# 톰캣 설치 파일 다운로드 실행 및 압축해제            
RUN wget https://archive.apache.org/dist/tomcat/tomcat-10/v10.0.23/bin/apache-tomcat-10.0.23.tar.gz;
RUN tar -xf apache-tomcat-10.0.23.tar.gz  --strip-components=1;


# war 파일 복사
COPY ./sample.war $CATALINA_HOME/webapps

# jdbc driver jar 복사
COPY ./mysql-connector-j-8.0.33.jar ../openjdk-10/lib
COPY ./mysql-connector-j-8.0.33.jar /usr/local/tomcat/lib/

# 컨테이너에서 사용할 포트
EXPOSE 8081

# 설정 완료 후 실행
CMD ["catalina.sh", "run"]
