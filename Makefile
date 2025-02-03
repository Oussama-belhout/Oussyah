# Compiler and tools
CC=gcc
FLEX=flex
BISON=bison

# Source files
LEX_FILE=lexical.l
YACC_FILE=synt.y

# Output files
LEX_OUTPUT=lex.yy.c
YACC_OUTPUT=synt.tab.c
EXECUTABLE=tp

# Build rules
all: $(EXECUTABLE)

$(YACC_OUTPUT): $(YACC_FILE)
	$(BISON) -d $(YACC_FILE)

$(LEX_OUTPUT): $(LEX_FILE)
	$(FLEX) $(LEX_FILE)

$(EXECUTABLE): $(LEX_OUTPUT) $(YACC_OUTPUT)
	$(CC) $(LEX_OUTPUT) $(YACC_OUTPUT) -lfl -o $(EXECUTABLE)

clean:
	rm -f $(LEX_OUTPUT) $(YACC_OUTPUT) synt.tab.h $(EXECUTABLE)

