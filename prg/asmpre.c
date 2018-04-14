#include <stdio.h>
#include <string.h>
#include <ctype.h>

struct{
	char *obj;
	char *replace;
} replace

int parse(char *line){
	while(isspace(*(line++))) ;
	if (*(line++) == '#'){
		#define syntax_error() do{ fprintf(stderr, "syntax error. \n"); return 1; }while(0)
		char *token;

		if ((token = strtok(line, " ")) == NULL) syntax_error();
		if (strcmp(token, "define")){
			if ((token = strtok(NULL, " ")) == NULL) syntax_error();
			
		}else syntax_error();
	}else{
	}

	return 0;
}

int main(){

	while(!feof(stdin)){
		char line[256];
		fgets(line, 256, stdin);
		if (parse(line)) return 1;
		printf(line);
	}

	return 0;
}
