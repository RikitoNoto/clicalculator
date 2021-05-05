all: src/*
	sudo crystal build -o bin/calc src/main.cr
	sudo mv ./bin/calc /bin/calc