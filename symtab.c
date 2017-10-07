#include "symtab.h"


void insert_record (char *name, double data) {
	Table *n = (Table*)malloc(sizeof(Table));
	if (n == NULL) {
		printf(BOLDRED"Memory not allocated\n"WHITE);
		exit(-1);
	}
	n->name = (char*)malloc(sizeof(name));
	strcpy(n->name, name);
	n->data = data;
	if (stab == NULL) {
		stab = n;
		stab->next = NULL;
		last = stab;
		return;
	}
	last->next = n;
	last = n;
}

Table *lookup(char *name) {
	Table *temp = stab;
	while ( temp != NULL && strcmp(temp->name, name) != 0) {
		temp = temp->next;
	}
	return temp;
}