#include "func.h"
#include "cudaHeaders.h"

__global__ void addKernel(int *c, const int *a, const int *b)
{
    int idx = (blockIdx.x * blockDim.x) + threadIdx.x;
    c[idx]  = a[idx] + b[idx];
}

void VectorAdd(int *C, const int *A, const int *B)
{
    int *devA = new int[5];
    int *devB = new int[5];
    int *devC = new int[5];

    cudaMalloc((void**)&devA, sizeof(int)*5);
    cudaMemcpy(devA, A, sizeof(int)*5, cudaMemcpyHostToDevice);
    
    cudaMalloc((void**)&devB, sizeof(int)*5);
    cudaMemcpy(devB, B, sizeof(int)*5, cudaMemcpyHostToDevice);   
 
    cudaMalloc((void**)&devC, sizeof(int)*5);
    cudaMemcpy(devC, C, sizeof(int)*5, cudaMemcpyHostToDevice);
    
    addKernel<<<1,32>>>(devC, devA, devB);    
    
    cudaMemcpy(C, devC, sizeof(int)*5, cudaMemcpyDeviceToHost);

    cudaFree(devA);
    cudaFree(devB);
    cudaFree(devC);    
}