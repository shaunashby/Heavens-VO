#!perl -T

use Test::More tests => 3;

use VO::Exception;

my $except = VO::Exception->new("Exception type 1234");

ok(ref($except) eq 'VO::Exception',"Instantiation of VO::Exception.");
can_ok($except,'what');
ok($except->what eq 'Exception type 1234',"Exception message retrieval.");
