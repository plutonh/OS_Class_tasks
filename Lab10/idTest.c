#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>

void main(void)
{
	printf("I am process %1ld\n", (long)getpid());
	printf("My parent process id is %1ld\n", (long)getppid());
}
