#!perl -T

use Test::More tests => 5;

use VO;
use VO::Service;

my $service = VO::Service->new({ context => VO->context });
ok(ref($service) eq 'VO::Service',"Service instantiation.");

ok($service->status == 0, "VO Service error status.");

$service->error("A funny error occurred.");

ok($service->status == 1, "VO Service error status with one error logged.");

# Check the service configuration:
ok(ref($service->config) eq 'HASH',"Service returns service definition as hash ref.");
ok(scalar(keys %{ $service->config->{instruments} }) == 2,"Service configuration has correct number of instruments.");
