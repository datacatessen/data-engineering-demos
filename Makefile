
all:
	mkdir -p hadoop/dfs/name hadoop/dfs/data
	mkdir -p mariadb
	cd nifi && mkdir -p content_repository database_repository flowfile_repository provenance_repository
	docker-compose up --build

down:
	docker-compose down
