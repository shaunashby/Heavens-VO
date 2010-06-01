#!perl -T

use Test::More tests => 3;

use VO;
use VO::Service::Cutout;

my $service = VO::Service::Cutout->new({ context => VO->context });
ok(ref($service) eq 'VO::Service::Cutout',"Cutout service instantiation.");
ok($service->isa('VO::Service'),"Cutout ISA VO::Service.");
ok($service->can('image_query'),"Cutout service supports the image_query method.");

#              "BaseDir=/Users/Shared/projects/isdcvo/rep/arc/rev_3",
#              "Axis_RA=288.778680",
#              "Axis_DEC=10.926354",
#              "Size_RA=20",
#              "Size_DEC=20",
#              "Instrument=jemx"

#$service->image_query({ pos => "288.778,10.926", size => 20., format => 'image/fits' });
