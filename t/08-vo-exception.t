#!perl -T

use Test::More tests => 4;

use VO::Exception;
use VO::QueryStatus qw(:common);

my $except = VO::Exception->new(ERROR,"Exception type 1234");

ok(ref($except) eq 'VO::Exception',"Instantiation of VO::Exception.");
can_ok($except,'type');
can_ok($except,'what');
ok($except->what eq 'Exception type 1234',"Exception message retrieval.");
