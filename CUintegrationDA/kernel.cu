#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include<iostream>

#include <stdio.h>



__device__ double fun(double x) {
	//return x;
	//return x*x/2+3*x-1/x;
	return (.5 * x * x) + (3 * x) - (1 / x);
}



__global__ void sumintegral(double lowbound1, int n, double dx)
{
	
	double c = 0;
	for (int i = 0; i < n; i++) {
		double xi = lowbound1 + (i * dx);
		double funValue = fun(xi);
		double rectangleArea = funValue * dx;
		c += rectangleArea;

	}
	printf("%f ",c);
	
}


int main() {
	
	double lowbound1 = 3;	
	long int n = 1;	
	double dx = (double)lowbound1/n;	
	 sumintegral << <1, 1 >> > (lowbound1, n, dx);
    return 0;
}