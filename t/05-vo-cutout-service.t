#!perl -T

use Test::More tests => 3;

use VO;
use VO::Service::Cutout;

my $service = VO::Service::Cutout->new({ context => VO->context });
ok(ref($service) eq 'VO::Service::Cutout',"Cutout service instantiation.");
ok($service->isa('VO::Service'),"Cutout ISA VO::Service.");
ok($service->can('image_query'),"Cutout service supports the image_query method.");
