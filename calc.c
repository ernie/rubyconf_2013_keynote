#include <stdio.h>

int main() {
  int a = -1;
  int b = -1;
  int c = -1;

  while (a != 0 || b != 0) {
    printf("Enter two numbers (0 0 to quit): ");
    scanf("%d%d", &a, &b);

    c = a + b;

    printf("The sum of the numbers you entered is %d\n", c);
  }
}
