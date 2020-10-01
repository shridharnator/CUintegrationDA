#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include<iostream>

#include <stdio.h>



__device__ double fun(double x) {
	//return x;
	//return x*x/2+3*x-1/x;
	return (.5 * x * x) + (3 * x) - (1 / x);
}



__global__ void sumintegral(double lowbound1, int n, double dx,double *d_c)
{
	
	//double c = 0;
	for (int i = 0; i < n; i++) {
		double xi = lowbound1 + (i * dx);
		double funValue = fun(xi);
		double rectangleArea = funValue * dx;
		*d_c += rectangleArea;

	}
	//printf("%f ",c);
	
}


int main() {
	
	double lowbound1 = 3;	
	long int n = 1;	
	double c;
	double *d_c;
	double size = sizeof(double);
	cudaMalloc((void**)&d_c, size);
	c = 0;
	cudaMemcpy(&d_c, &c, size, cudaMemcpyHostToDevice);
	
	double dx = (double)lowbound1/n;	
	 sumintegral << <1, 1 >> > (lowbound1, n, dx,d_c);
	 cudaMemcpy(&c, &d_c, size, cudaMemcpyDeviceToHost);
	 cudaFree(&d_c);
	 printf("%f", c);
    return 0;
}