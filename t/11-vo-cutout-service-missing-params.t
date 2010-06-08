#!perl -T

use Test::More tests => 4;

use VO;
use VO::Service::Cutout;

$ENV{WCS_TEST_MODE} = 1; # don't actually run the wcs executable since it hangs under test_harness.

my $context = VO->context;
my $service = VO::Service::Cutout->new({ context => $context });

my $POS    = "299.6,+35.2"; # Good values
my $SIZE   = "20,20";
my $FORMAT = "image%2Ffits";
my $INTERSECT = 'OVERLAPS';

# Check missing POS parameter:
$service->image_query( { size   => $SIZE,
			 format => $FORMAT,
                         intersect => $INTERSECT } );    

ok($service->status == 1,"Service status value 1 after failure running query.");

# Dump the errors from the context:
isa_ok($context->errors->[0],'VO::Exception');
can_ok($context->errors->[0],'what');
ok($context->errors->[0]->what eq "Position parameter POS must be provided.","Error message is correct for missing POS parameter.");
