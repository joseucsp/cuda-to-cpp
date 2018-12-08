#include "cudaMain.h"
#include "func.h"
using namespace std;

int cudaMain(int argc, char **argv) {  
    int *A = new int[5];
    int *B = new int[5];

    int *C = new int[5];

    for(int i = 0; i < 5; i++)
    {
        A[i] = i;
        B[i] = 2*i;
    }

    VectorAdd(C, A, B);

    for(int i = 0; i < 5; i++)
    {
        std::cout << "\n===============>" << std::endl;
        std::cout << "\nA[" << i << "] = " << A[i] << std::endl;
        std::cout << "B[" << i << "] = " << B[i] << std::endl;
        std::cout << "C[" << i << "] = " << C[i] << std::endl;
    }
    std::cout << std::endl;
    return 0;
}