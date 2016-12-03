use warnings;
use strict;
use DB_File;

my ($filename, $x, %h, $found);

$filename = "tree";

$x = tie %h, "DB_File", $filename, O_RDWR|O_CREAT, 0666, $DB_BTREE
    or die "Cannot open $filename: $!\n";

$found = ( $x->find_dup('Wall', 'Larry') == 0 ? "" : "not" );
print "Larry Wall is $found there\n";

$found = ( $x->find_dup("Wall", "Harry") == 0 ? "" : "not" );
print "Harry Wall is $found there\n";

undef $x;
untie %h;

