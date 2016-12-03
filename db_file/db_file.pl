use warnings;
use strict;
use DB_File;
our (%h, $k, $v);

unlink "fruit";

tie %h, "DB_File", "fruit", O_RDWR|O_CREAT, 0666, $DB_HASH
    or die "Cannot open file 'fruit': $!\n";

$h{"apple"} = "red";
$h{"orange"} = "orange";
$h{"banana"} = "yellow";
$h{"tomato"} = "red";

# check for existence of a key
print "Banana Exists\n\n" if $h{"banana"};

# delete a key/value pair
delete $h{"apple"};

# print the contents of the file
while (($k, $v) = each %h)
    { print "$k -> $v\n" }

untie %h;

