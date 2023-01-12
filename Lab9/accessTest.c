#include <sys/types.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv)
{
	if(argc!=2)
	{
		printf("usage: accessTest.x <pathname>\n");
		exit(1);
	}
	
	if(access(argv[1], R_OK) < 0)
		printf("Access error for %s\n", argv[1]);
	else
		printf("Read access OK\n");
	
	if(open(argv[1], O_RDONLY) < 0)
		printf("Open error for %s\n", argv[1]);
	else
	{
		printf("Open for reading OK\n");
		exit(0);
	}
}
