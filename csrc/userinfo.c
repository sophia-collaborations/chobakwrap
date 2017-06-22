#include <stdio.h>
#include <unistd.h>

static void st_precolos ( void );

int main( int argc, char **argv, char **env )
{
  long lc_alpha;
  printf("{");

  // The Real User ID
  lc_alpha = (long)getuid();
  st_precolos();
  printf("\"uid\":%ld",lc_alpha);

  // The Effective User ID
  lc_alpha = (long)geteuid();
  st_precolos();
  printf("\"euid\":%ld",lc_alpha);

  // The Real Group ID
  lc_alpha = (long)getgid();
  st_precolos();
  printf("\"gid\":%ld",lc_alpha);

  // The Effective Group ID
  lc_alpha = (long)getegid();
  st_precolos();
  printf("\"egid\":%ld",lc_alpha);

  printf("\n}\n");
  fflush(stdout);
}

static void st_precolos ( void )
{
  static int lc_a = 0;
  if ( lc_a > 5 ) { putchar(','); }
  lc_a = 10;
  printf("\n  ");
}



