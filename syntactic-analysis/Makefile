all: compile run
	echo "lorem ipsum"

run:
	@./output

compile:
	@bison -y -d ./src/syntactic.y -o ./src/y.tab.c
	@flex ./src/syntactic.l
	@# Jerry rig - https://github.com/westes/flex/issues/422
	@cp ./lex.yy.c ./src
	@rm ./lex.yy.c
	@# End of jerry rig
	@gcc -c ./src/y.tab.c -o ./src/y.tab.o
	@gcc -c ./src/lex.yy.c -o ./src/lex.yy.o
	@gcc -c ./src/hash.c -o ./src/hash.o
	@gcc ./src/hash.o ./src/y.tab.o ./src/lex.yy.o -o output

docker:
	@docker build -t syntacticanalysis .
	@docker tag syntacticanalysis:latest fazenda/syntacticanalysis
	@docker push fazenda/syntacticanalysis

zip:
	echo "lorem ipsum"
