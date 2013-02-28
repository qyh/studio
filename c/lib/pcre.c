/*************************************************
*           PCRE DEMONSTRATION PROGRAM           *
*************************************************/

/* This is a demonstration program to illustrate the most straightforward ways
of calling the PCRE regular expression library from a C program. See the
pcresample documentation for a short discussion ("man pcresample" if you have
the PCRE man pages installed).

In Unix-like environments, if PCRE is installed in your standard system
libraries, you should be able to compile this program using this command:

gcc -Wall pcredemo.c -lpcre -o pcredemo

If PCRE is not installed in a standard place, it is likely to be installed with
support for the pkg-config mechanism. If you have pkg-config, you can compile
this program using this command:

gcc -Wall pcredemo.c `pkg-config --cflags --libs libpcre` -o pcredemo

If you do not have pkg-config, you may have to use this:

gcc -Wall pcredemo.c -I/usr/local/include -L/usr/local/lib \
  -R/usr/local/lib -lpcre -o pcredemo

Replace "/usr/local/include" and "/usr/local/lib" with wherever the include and
library files for PCRE are installed on your system. Only some operating
systems (e.g. Solaris) use the -R option.

Building under Windows:

If you want to statically link this program against a non-dll .a file, you must
define PCRE_STATIC before including pcre.h, otherwise the pcre_malloc() and
pcre_free() exported functions will be declared __declspec(dllimport), with
unwanted results. So in this environment, uncomment the following line. */

/* #define PCRE_STATIC */

#include <stdio.h>
#include <string.h>
#include <pcre.h>

#define OVECCOUNT 30    /* should be a multiple of 3 */


int main(int argc, char **argv)
{
pcre *re;
const char *error;
char *pattern;
char *subject;
unsigned char *name_table;
unsigned int option_bits;
int erroffset;
int find_all;
int crlf_is_newline;
int namecount;
int name_entry_size;
int ovector[OVECCOUNT];
int subject_length;
int rc, i;
int utf8;


/**************************************************************************
* First, sort out the command line. There is only one possible option at  *
* the moment, "-g" to request repeated matching to find all occurrences,  *
* like Perl's /g option. We set the variable find_all to a non-zero value *
* if the -g option is present. Apart from that, there must be exactly two *
* arguments.                                                              *
**************************************************************************/

find_all = 0;
for (i = 1; i < argc; i++)
  {
  if (strcmp(argv[i], "-g") == 0) find_all = 1;
    else break;
  }

/* After the options, we require exactly two arguments, which are the pattern,
and the subject string. */

if (argc - i != 2)
  {
  printf("Two arguments required: a regex and a subject string\n");
  return 1;
  }

pattern = argv[i];
subject = argv[i+1];
subject_length = (int)strlen(subject);


/*************************************************************************
* Now we are going to compile the regular expression pattern, and handle *
* and errors that are detected.                                          *
*************************************************************************/

re = pcre_compile(
  pattern,              /* the pattern */
  0,                    /* default options */
  &error,               /* for error message */
  &erroffset,           /* for error offset */
  NULL);                /* use default character tables */

/* Compilation failed: print the error message and exit */

if (re == NULL)
  {
  printf("PCRE compilation failed at offset %d: %s\n", erroffset, error);
  return 1;
  }


/*************************************************************************
* If the compilation succeeded, we call PCRE again, in order to do a     *
* pattern match against the subject string. This does just ONE match. If *
* further matching is needed, it will be done below.                     *
*************************************************************************/

rc = pcre_exec(
  re,                   /* the compiled pattern */
  NULL,                 /* no extra data - we didn't study the pattern */
  subject,              /* the subject string */
  subject_length,       /* the length of the subject */
  0,                    /* start at offset 0 in the subject */
  0,                    /* default options */
  ovector,              /* output vector for substring information */
  OVECCOUNT);           /* number of elements in the output vector */

/* Matching failed: handle error cases */

if (rc < 0)
  {
  switch(rc)
    {
    case PCRE_ERROR_NOMATCH: printf("No match\n"); break;
    /*
    Handle other special cases if you like
    */
    default: printf("Matching error %d\n", rc); break;
    }
  pcre_free(re);     /* Release memory used for the compiled pattern */
  return 1;
  }

/* Match succeded */

printf("\nMatch succeeded at offset %d\n", ovector[0]);


/*************************************************************************
* We have found the first match within the subject string. If the output *
* vector wasn't big enough, say so. Then output any substrings that were *
* captured.                                                              *
*************************************************************************/

/* The output vector wasn't big enough */

if (rc == 0)
  {
  rc = OVECCOUNT/3;
  printf("ovector only has room for %d captured substrings\n", rc - 1);
  }

/* Show substrings stored in the output vector by number. Obviously, in a real
application you might want to do things other than print them. */

for (i = 0; i < rc; i++)
  {
  char *substring_start = subject + ovector[2*i];
  int substring_length = ovector[2*i+1] - ovector[2*i];
  printf("%2d: %.*s\n", i, substring_length, substring_start);
  }
}
