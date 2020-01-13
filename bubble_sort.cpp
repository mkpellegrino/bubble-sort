#include <stdlib.h>
#include <stdio.h>

using namespace std;

extern "C" int bubble_sort_character(void*); // returns how many swaps the function had to make in order to sort
extern "C" int bubble_sort_double(void*,int); // returns how many swaps the function had to make in order to sort
extern "C" int bubble_sort_integer(void*,int); // returns how many swaps the function had to make in order to sort
extern "C" int bubble_sort_float(void*,int); // returns how many swaps the function had to make in order to sort

static double array_of_doubles[]={0,-4.229884,8.617109,-6.555063,4.475448,0,0,-6.199282,0.280584,-0.227588,8.818649,-4.914553};
static char array_of_characters[]="JHDGJKDHjh";
static int array_of_integers[]={52,-97,19,4,0,69,98,9,-27,26};
//static int array_of_integers[]={52,-97,19};
static float array_of_floats[]={-4.229884,8.617109,0,0,0,-6.555063,4.475448,-6.199282,0.280584,-0.227588,8.818649,-4.914553,-4.914553};


int main(int argc, char **argv)
{
  int y=0;
  unsigned long s=0;
  float x=array_of_floats[0];

  s= sizeof(array_of_floats)/sizeof(float);
  printf( "=================================\n" );
  printf( "Sorting Array of type float.\n" );
   printf( "Size of array: %lu (%lu per element)\n", s, sizeof(float) );

  printf( "            Original: ");
  for( int i=0; i<s; i++ )
    {
      printf( "%lf", array_of_floats[i] );
      if( i<s-1 ) printf(",");
    }
  printf( "\n" );

  y = bubble_sort_float( array_of_floats, s );

  printf( "  Sorted in %d swaps: ",y );
  for( int i=0; i<s; i++ )
    {
      printf( "%lf", array_of_floats[i] );
      if( i<s-1 ) 
	{
	  printf(",");
	}
      else
	{
	  printf("\n");
	}
    }
  

  
  s= sizeof(array_of_doubles)/sizeof(double);
  printf( "=================================\n" );
  printf( "Sorting Array of type double.\n" );
  printf( "Size of array: %lu\n", s );
  printf( "            Original: ");

  for( int i=0; i<s; i++ )
    {
      printf( "%lf", array_of_doubles[i] );
      if( i<s-1 ) printf(",");
    }
  printf( "\n" );
  y = bubble_sort_double( array_of_doubles, s );
  printf( "  Sorted in %d swaps: ",y );
  for( int i=0; i<s; i++ )
    {
      printf( "%lf", array_of_doubles[i] );
      if( i<s-1 ) 
	{
	  printf(",");
	}
      else
	{
	  printf("\n");
	}
    }
  
  printf( "=================================\n" );

  printf( "Sorting Array of type character.\n" );
  printf( "Size of array: %lu\n", s );

  printf( "            Original: %s\n", array_of_characters);
  y = bubble_sort_character( array_of_characters );
  printf( "  Sorted in %d swaps: %s\n",y, array_of_characters );
  printf( "=================================\n" );
  
  
  s= sizeof(array_of_integers)/sizeof(int);
  printf( "Sorting Array of type integer.\n" );
  printf( "Size of array: %lu (%lu per element)\n", s, sizeof(int) );
  printf( "            Original: ");

  for( int i=0; i<s; i++ )
    {
      printf( "%d", array_of_integers[i] );
      if( i<s-1 ) printf(",");
    }
  printf( "\n" );
  y = bubble_sort_integer( array_of_integers, s );
  printf( "  Sorted in %d swaps: ",y );
  for( int i=0; i<s; i++ )
    {
      printf( "%d", array_of_integers[i] );
      if( i<s-1 ) printf(",");
    }
  printf( "\n=================================\n" );

  
  
  return(0);
}
