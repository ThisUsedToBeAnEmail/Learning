use warnings;
use strict;
my (@h, $H, $file, $i);
use DB_File;
use Fcntl;

$file = "text";

unlink $file;

$H = tie @h, "DB_File", $file, O_RDWR|O_CREAT, 0666, $DB_RECNO 
    or die "Cannot open file $file: $!\n";

# first create a text file to play with
$h[0] = "zero";
$h[1] = "one";
$h[2] = "two";
$h[3] = "three";
$h[4] = "four";


# Print the records in order.
#
# The length method is needed here because evaluating a tied
# array in a scalar context does not return the number of
# elements in the array.  

print "\nORIGINAL\n" ;
foreach $i (0 .. $H->length - 1) {
    print "$i: $h[$i]\n" ;
}

# use the push & pop methods
$a = $H->pop ;
$H->push("last") ;
print "\nThe last record was [$a]\n" ;

# and the shift & unshift methods
$a = $H->shift ;
$H->unshift("first") ;
print "The first record was [$a]\n" ;

# Use the API to add a new record after record 2.
$i = 2 ;
$H->put($i, "Newbie", R_IAFTER) ;

# and a new record before record 1.
$i = 1 ;
$H->put($i, "New One", R_IBEFORE) ;

# delete record 3
$H->del(3) ;

# now print the records in reverse order
print "\nREVERSE\n" ;
for ($i = $H->length - 1 ; $i >= 0 ; -- $i)
  { print "$i: $h[$i]\n" }

# same again, but use the API functions instead
print "\nREVERSE again\n" ;
my ($s, $k, $v)  = (0, 0, 0) ;
for ($s = $H->seq($k, $v, R_LAST) ; 
	 $s == 0 ; 
	 $s = $H->seq($k, $v, R_PREV))
  { print "$k: $v\n" }

undef $H ;
untie @h ;
