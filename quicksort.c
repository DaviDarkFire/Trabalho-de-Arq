#include <stdio.h>

int separa (int v[], int p, int r)
{
   int c = v[p], i = p+1, j = r, t;
   while (i <= j) {
      if (v[i] <= c) ++i;
      else if (c < v[j]) --j;
      else {
         t = v[i], v[i] = v[j], v[j] = t;
         ++i; --j;
      }
   }
   v[p] = v[j], v[j] = c;
   return j;
}

void quicksort (int v[], int p, int r)
{
   int j;                         // 1
   if (p < r) {                   // 2
      j = separa (v, p, r);       // 3
      quicksort (v, p, j-1);      // 4
      quicksort (v, j+1, r);      // 5
   }
}

int main(void){
        int n;
        scanf("%d", &n);
        int v[n];
        for(int i = 0; i < n; i++){
                scanf("%d", &v[i]);
        }
        quicksort(v, 0, n-1);
        printf("\n");
        for(int i = 0; i < n; i++){
                printf("%d ", v[i]);
        }
        printf("\n");
        return 0;
}
