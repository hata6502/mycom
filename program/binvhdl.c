#include <stdio.h>

int main(){
	const char *instruction[] = {
		"IS_READ", "IS_WRITE", "IS_ADD", "IS_SUB", "IS_MUL", "IS_DIV", "IS_AND", "IS_OR", "IS_XOR", "IS_BRANCH", "IS_EQ", "IS_NEQ", "IS_LT", "IS_LTE", "IS_GT", "IS_GTE", 
	};

	while(!feof(stdin)){
		int ins;

		fread(&ins, sizeof(int), 1, stdin);
		printf("is_word(%s, %d), \n", instruction[ins>>16], ins&((1<<16) - 1));
	}
}
