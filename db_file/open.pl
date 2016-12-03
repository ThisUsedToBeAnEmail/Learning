use warnings;
use strict;
use DB_File;
use feature 'say';

my ($filename, $x, %h);

$filename = "tree";

sub compare 
{
    my ($key1, $key2) = @_;
    "\L$key1" cmp "\L$key2";
}

$DB_BTREE->{'compare'} = \&compare;

$x = tie %h, "DB_File", "tree", O_RDWR|O_CREAT, 0666, $DB_BTREE
    or die "Cannot open file 'tree': $!\n";

my $cnt = $x->get_dup('Wall');
say $cnt;

my @list = $x->get_dup('mouse');
say @list;



