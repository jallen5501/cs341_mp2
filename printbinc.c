/* printbinc.c: driver for printbin.s 
   bob wilson 01/20/2012 
   */

extern char *printbin(unsigned char);

int main(char **args)
{
  unsigned int x;

  printf("number to print in binary: \n");
  scanf("%x",&x);
  printf("The binary format for %x is %s\n", 
                                 x,   printbin((unsigned char)x));
  return 0;
}

