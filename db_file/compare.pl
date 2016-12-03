use warnings;
use strict;
use DB_File;

my %h;

sub compare 
{
    my ($key1, $key2) = @_;
    "\L$key1" cmp "\L$key2";
}

$DB_BTREE->{'compare'} = \&compare;

unlink "tree";
tie %h, "DB_File", "tree", O_RDWR|O_CREAT, 0666, $DB_BTREE
    or die "Cannot open file 'tree': $!\n";

$h{'Wall'} = 'Larry';
$h{'apple'} = 'What';
$h{'Smith'} = 'John';
$h{'mouse'} = 'mickey';
$h{'duck'} = 'donald';

foreach (keys %h)
    { print "$_\n" }

untie %h;




