#ifndef SYMTAB_H
#define SYMTAB_H
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#define WHITE "\033[37m"
#define BOLDRED     "\033[1m\033[31m"
#define BOLDGREEN   "\033[1m\033[32m"
#define BLUE		"\x1b[36m"
typedef struct tab {

	char *name;
	double data;
	struct tab *next;
} Table;

Table *stab, *last;

void insert_record(char *, double);
Table *lookup(char *);


#endif