#!perl -T

use Test::More tests => 7;

use VO;
use VO::Service::Cutout;

my $context1 = VO->context;
my $service1 = VO::Service::Cutout->new({ context => $context1 });

my $POS    = "299.6,+35.2"; # Good values
my $SIZE   = "20,20";
my $FORMAT = "image%2Ffits";
my $INTERSECT = 'OVERLAPS';

# Check running query with out-of-range RA:
$POS="379,35.2";

$service1->image_query( { pos    => $POS,
			  size   => $SIZE,
			  format => $FORMAT,
                          intersect => $INTERSECT } );    

ok($service1->status == 1,"Service status value 1 after failure running query.");

# Dump the errors from the context:
isa_ok($context1->errors->[0],'VO::Exception');
can_ok($context1->errors->[0],'what');
ok($context1->errors->[0]->what eq "RA must be in the range 0,360.","Error message is correct for out-of-range RA value in POS $POS.");


# Another test with bad DEC value:
my $context2 = VO->context;
my $service2 = VO::Service::Cutout->new({ context => $context2 });

# Check running query with out-of-range DEC too:
$POS="379.,+123.3";

$service2->image_query( { pos    => $POS,
 			  size   => $SIZE,
 			  format => $FORMAT,
                          intersect => $INTERSECT } );    

# Dump the errors from the context:
isa_ok($context2->errors->[0],'VO::Exception');
can_ok($context2->errors->[0],'what');
ok($context2->errors->[0]->what eq "DEC must be in the range -90,90.","Error message is correct for out-of-range DEC value in POS $POS.");
