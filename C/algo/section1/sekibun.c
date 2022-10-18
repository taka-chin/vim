#include <stdio.h>
#include <stdlib.h>
#define degreemax 20

double	horner(int n, char **input, double width)
{
	double	output;
	int		i;
	double	x0;

	output = 0;
	i = 0;
	/* x0 = atof(input[n + 2]); */
	x0 = width;
	while (n - i)
	{
		if (i == 0)
		{
			output = atof(input[1]) * x0 + atof(input[2]);
		}
		else
		{
			output = output * x0 + atof(input[i + 2]);
		}
		i++;
	}
	return (output);
}

double	calculate(int n, char **str)
{
	double	width;
	double	height;
	double	sum;
	int		count;
	int		i;

	count = 1000;
	/* width = 1 / count; */
	width = 0.001;
	sum = 0.0;
	i = 1;
	while (i <= count)
	{
		height = horner(n, str, width * i);
		sum = sum + width * height;
		i++;
	}
	return (sum);
}

int	main(int argc, char *argv[])
{
	char	**input;
	int		i;
	int		j;
	int		degree;

	i = 1;
	j = 0;
	degree = argc - 2;
	printf("次数:%d\n", degree);
	while (argc - i - 1)
	{
		printf("係数:%s\n", argv[i]);
		i++;
	}
	/* printf("x is:%s\n", argv[argc - 1]); */
	while (degree >= j)
	{
		if (degree != j)
		{
			printf("%sx^%d ", argv[j + 1], degree - j);
			printf("+ ");
		}
		else
		{
			printf("%s ", argv[j + 1]);
		}
		j++;
	}
	/* printf("(x=%s)", argv[argc - 1]); */
	puts("");
	/* input = argv[]; */
	printf("定積分(0→1):%f\n", calculate(degree, argv));
	/* calculate(); */
}
