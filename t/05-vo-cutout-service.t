#!perl -T

use Test::More tests => 5;

use VO;
use VO::Service::Cutout;
my $context = VO->context;

my $service = VO::Service::Cutout->new({ context => $context });
ok(ref($service) eq 'VO::Service::Cutout',"Cutout service instantiation.");
can_ok($service,'image_query');
can_ok($service,'error');
isa_ok($service,'VO::Service');

my $POS    = "299.6,+35.2";
my $SIZE   = "20,20";
my $FORMAT = "image%2Ffits";
my $INTERSECT = 'OVERLAPS';

# Check running query with well-defined parameters:
$service->image_query( { pos    => $POS,
			 size   => $SIZE,
			 format => $FORMAT,
                         intersect => $INTERSECT } );

ok($service->status == 0,"Service status value 0 after successfully running query.");
