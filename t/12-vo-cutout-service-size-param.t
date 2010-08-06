#!perl -T

use Test::More tests => 4;

use VO;
use VO::Service::Cutout;

my $context = VO->context;
my $service = VO::Service::Cutout->new({ context => $context });

my $POS    = "299.6,+35.2"; # Good values
my $SIZE   = "55,20";
my $FORMAT = "image%2Ffits";
my $INTERSECT = 'OVERLAPS';

# Check missing POS parameter:
$service->image_query( { pos    => $POS, 
 		         size   => $SIZE,
			 format => $FORMAT,
                         intersect => $INTERSECT } );    

ok($service->status == 1,"Service status value 1 after failure running query.");

# Dump the errors from the context:
isa_ok($context->errors->[0],'VO::Exception');
can_ok($context->errors->[0],'what');
ok($context->errors->[0]->what eq "SIZE exceeds maximum allowed image size.","Error message is correct for too large SIZE parameter.");
