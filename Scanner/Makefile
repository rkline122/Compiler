scan: out/main.o out/scanner.o
	gcc out/main.o out/scanner.o -o out/scan

out/main.o: main.c token.h
	gcc main.c -c -o out/main.o

out/scanner.o: scanner.c token.h
	gcc scanner.c -c -o out/scanner.o

scanner.c: scanner.flex
	flex -o out/scanner.c scanner.flex

clean:
	rm -f out/scanner.c out/scanner.o out/main.o out/scan
