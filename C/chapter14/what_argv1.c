#include <stdio.h>

int	main(int argc, char *argv[])
{
	char	**p;
	char	*q;

	p = argv;
	while (*p)
	{
		q = *p;
		while (*q)
		{
			printf("%c ", *q);
			q++;
		}
		p++;
	}
}
