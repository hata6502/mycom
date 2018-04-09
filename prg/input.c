void main(){
	static int i;

	i = 0;
	while(i!=16){
		static int j;

		j = 0;
		while(j!=16){
			1024[i*40 + j] = 42;
			j = j + 1;
		}
	}

	while(1);
}
