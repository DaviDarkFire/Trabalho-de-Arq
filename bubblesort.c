#include <stdio.h>

void meuBubbleSortPutao(int v[], int n){
  int temp;
  for(int i = n-1; i > 0; i--){
    for(int j = 0; j < i; j++){
      if (v[j] > v[j+1]){
	temp = v[j];
	v[j] = v[j+1];
	v[j+1] = temp;
      }
    }
  }
}

int main(void){
        int n;
        scanf("%d", &n);
        int v[n];
        for(int i = 0; i < n; i++){
                scanf("%d", &v[i]);
        }
        meuBubbleSortPutao(v, n);
        printf("\n");
        for(int i = 0; i < n; i++){
                printf("%d ", v[i]);
        }
        printf("\n");
        return 0;




}
