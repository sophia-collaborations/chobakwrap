#include <stdio.h>
#include <ctype.h>

typedef struct OUTDST {
  int (*fnc) (struct OUTDST *rg_a, char rg_b);
  FILE *fl;
} OUTDST;

int set_outdst (OUTDST *rg_a, FILE *rg_b);
// This function initializes the OUTDST (rg_a) which
// outputs to a specified FILE stream (rg_b).

int outp_start (struct OUTDST *rg_a, char rg_b);
// This is the initial output function used in an
// OUTDST structure as set by set_outdst().

int outp_newln (struct OUTDST *rg_a, char rg_b);
// This function is just like outp_start only it
// prevents blank-lines.

int outp_squot (struct OUTDST *rg_a, char rg_b);
// This is the output function for inside single-quotes.

int outp_dquot (struct OUTDST *rg_a, char rg_b);
// This is the main output function for inside double-quotes.

int outp_descp (struct OUTDST *rg_a, char rg_b);
// This output function is for escape-sequences within the
// double-quotes.


int main ( int argc, char **argv, char **env )
{
  OUTDST lc_a;
  char lc_b;
  
  // Set the default function:
  set_outdst(&lc_a,stdout);
  
  // The output cycle:
  lc_b = fgetc(stdin);
  while ( !feof(stdin) )
  {
    lc_a.fnc(&lc_a,lc_b);
    lc_b = fgetc(stdin);
  }
  
  // Wrap things up:
  putchar('\n');
  fflush(stdout);
  return 0;
}

int set_outdst (OUTDST *rg_a, FILE *rg_b)
{
  // Be sure it isn't blank
  if ( rg_a == ((OUTDST *)NULL) ) { return 1; }
  
  // Do the assigning
  rg_a->fnc = outp_start;
  rg_a->fl = rg_b;
  
  // Conclusion:
  return 0;
}

int outp_start (struct OUTDST *rg_a, char rg_b)
{
  // Extraquote non-graphics are ignored.
  if ( !isgraph(rg_b) ) { return 0; }
  
  // What must a newline precede?
  if ( rg_b == '}' ) { fputc('\n',rg_a->fl); }
  if ( rg_b == ']' ) { fputc('\n',rg_a->fl); }
  
  // Output current character
  fputc(rg_b,rg_a->fl);
  
  // Enter quote mode:
  if ( rg_b == '\"' ) { rg_a->fnc = outp_dquot; }
  if ( rg_b == '\'' ) { rg_a->fnc = outp_squot; }
  
  // What must a newline follow?
  if ( rg_b == '{' ) { fputc('\n',rg_a->fl); rg_a->fnc = outp_newln; }
  if ( rg_b == '[' ) { fputc('\n',rg_a->fl); rg_a->fnc = outp_newln; }
  if ( rg_b == ',' ) { fputc('\n',rg_a->fl); rg_a->fnc = outp_newln; }
  
  // Conclusion:
  return 0;
}

int outp_newln (struct OUTDST *rg_a, char rg_b)
{
  // Extraquote non-graphics are ignored.
  if ( !isgraph(rg_b) ) { return 0; }
  
  // No double-newlines:
  rg_a->fnc = outp_start;
  
  // Output current character
  fputc(rg_b,rg_a->fl);
  
  // Enter quote mode:
  if ( rg_b == '\"' ) { rg_a->fnc = outp_dquot; }
  if ( rg_b == '\'' ) { rg_a->fnc = outp_squot; }
  
  // What must a newline follow?
  if ( rg_b == '{' ) { fputc('\n',rg_a->fl); rg_a->fnc = outp_newln; }
  if ( rg_b == '[' ) { fputc('\n',rg_a->fl); rg_a->fnc = outp_newln; }
  if ( rg_b == ',' ) { fputc('\n',rg_a->fl); rg_a->fnc = outp_newln; }
  
  // Conclusion:
  return 0;
}

int outp_squot (struct OUTDST *rg_a, char rg_b)
{
  fputc(rg_b,rg_a->fl);
  if (rg_b == '\'') { rg_a->fnc = outp_start; }
  return 0;
}

int outp_dquot (struct OUTDST *rg_a, char rg_b)
{
  fputc(rg_b,rg_a->fl);
  
  if (rg_b == '\"') { rg_a->fnc = outp_start; }
  if (rg_b == '\\') { rg_a->fnc = outp_descp; }
  
  return 0;
}

int outp_descp (struct OUTDST *rg_a, char rg_b)
{
  fputc(rg_b,rg_a->fl);
  rg_a->fnc = outp_dquot;
  return 0;
}



