current_dir=$(shell pwd)
version=$(shell bash ./build/version.sh)
date=$(shell date +%Y%m%d%H%M%S)
project_name=$(shell basename "${current_dir}")
remote_docker_image_registry=ccr.ccs.tencentyun.com/webankpartners/wecube-plugins-bdp


clean:
	rm -rf $(current_dir)/target

.PHONY:build
build: clean
	mkdir -p repository
	docker run \
	--rm \
	--name wecube-plugins-bdp-build \
	-v /data/repository:/usr/src/mymaven/repository \
	-v $(current_dir)/build/maven_settings.xml:/usr/share/maven/ref/settings-docker.xml \
	-v $(current_dir):/usr/src/mymaven \
	-w /usr/src/mymaven maven:3.3-jdk-8 mvn -U clean install -Dmaven.test.skip=true -s /usr/share/maven/ref/settings-docker.xml dependency:resolve

image: build
	docker build -t $(project_name):$(version) .

s3_server_url=http://10.10.10.1:9000
s3_access_key=access_key
s3_secret_key=secret_key
branch_name=dev

.PHONY:package
package: image
	rm -rf package
	mkdir -p package
	cd package && docker save $(project_name):$(version) -o image.tar
	cd package && cp ../register.xml .
	cd package && sed -i "s~{{REPOSITORY}}~$(project_name)~g" register.xml
	cd package && sed -i "s~{{VERSION}}~$(version)~g" register.xml
	cd $(current_dir) && git checkout $(branch_name) && git pull
	cd package && zip -r $(project_name)-$(version).zip .
	docker rmi $(project_name):$(version)

upload: package
	$(eval container_id:=$(shell docker run -v $(current_dir)/package:/package -itd --entrypoint=/bin/sh minio/mc))
	docker exec $(container_id) mc config host add wecubeS3 $(s3_server_url) $(s3_access_key) $(s3_secret_key) wecubeS3
	docker exec $(container_id) mc cp /package/$(project_name)-$(version).zip wecubeS3/wecube-plugin-package-bucket
	docker stop $(container_id)
	docker rm -f $(container_id)
