docker run -d -p 9001:8080 --name restful_crud -t restful-crud:1.0 -v $(pwd):/usr/app

ENTRYPOINT ["java", "-jar", "-Dspring.config.location=./config/", "CRUD-1.0.jar"]

url: "jdbc:sqlserver://docker.for.mac.localhost:1433;databaseName=trust_db;"
