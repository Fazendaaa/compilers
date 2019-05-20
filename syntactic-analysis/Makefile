all: compile run
	echo "lorem ipsum"

run:
	./output

compile:
	bison -y -d ./src/syntactic.y
	flex ./src/syntactic.l
	gcc -c ./src/y.tab.c ./src/lex.yy.c
	gcc ./src/y.tab.o ./src/lex.yy.o ./src/syntactic.c -o output

docker:
	docker build -t syntacticanalysis .
	docker tag syntacticanalysis:latest fazenda/syntacticanalysis
	docker push fazenda/syntacticanalysis

zip:
	echo "lorem ipsum"
