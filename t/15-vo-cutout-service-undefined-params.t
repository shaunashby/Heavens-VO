#!perl -T

use Test::More tests => 4;

use VO;
use VO::Service::Cutout;

my $context = VO->context;
my $service = VO::Service::Cutout->new({ context => $context });

my $POS    = "299.6,+35.2"; # Good values
my $SIZE   = "20,20";
my $FORMAT = "image%2Ffits";
my $INTERSECT = 'OVERLAPS';

# Check missing POS parameter:
$service->image_query( { pos => "",
			 size => $SIZE,
			 format => $FORMAT,
                         intersect => $INTERSECT } );    

ok($service->status == 1,"Service status value 1 after failure running 1st query.");
ok($context->errors->[0]->what eq "RA/DEC must be numeric and in range (0,360) and (-90,90).","Empty POS param correctly handled.");


# Check missing SIZE parameter:
my $context2 = VO->context;
my $service2 = VO::Service::Cutout->new({ context => $context2 });

$service2->image_query( { pos => $POS,
 			  size   => "",
 			  format => $FORMAT,
                          intersect => $INTERSECT } );    

ok($service2->status == 1,"Service status value 1 after failure running 2nd query.");
ok($context2->errors->[0]->what eq "SIZE must be an integer value.","Empty SIZE param correctly handled.");
