docker build -t php-apache:app --force-rm -f Dockerfile .

docker run -d --name php-app -v /datadocker/code/app:/code --net my-net php-apache:app
