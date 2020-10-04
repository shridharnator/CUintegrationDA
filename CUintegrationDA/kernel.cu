#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include<iostream>
//#include<stdlib.h>

#include <stdio.h>



__device__ double fun(double x) {
	//return x;
	//return x*x/2+3*x-1/x;
	return (.5 * x * x) + (3 * x) - (1 / x);
}



__global__ void sumintegral(double lowbound1, int n, double dx,double *d_c)
{
	
	//double c = 0;
	int i = threadIdx.x;
	//if(i<n) {
		/*double xi = lowbound1 + (i * dx);
		double funValue = fun(xi);
		double rectangleArea = funValue * dx;
		*d_c += rectangleArea;*/
		*d_c += 1;

		printf("love");
	//}
	//printf("%f ",c);
	
}


int main() {
	
	double lowbound1 = 3;	
	long int n = 10;	
	double c;

	c = 0;
	double *d_c;
	double size = sizeof(double);
	
	cudaMalloc((void**)&d_c, size);
	d_c = &c;
	//std::cout << *d_c << std::endl;
	
	//cudaMemcpy(d_c, &c, size, cudaMemcpyHostToDevice);
	
	double dx = (double)lowbound1/n;	
	 sumintegral << <1, 10 >> > (lowbound1, n, dx,d_c);
	 cudaDeviceSynchronize();
	// cudaMemcpy(&c, d_c, size, cudaMemcpyDeviceToHost); 
	 c = *d_c;
	
	 printf("%f", c);
	 cudaFree(&d_c);
    return 0;
}