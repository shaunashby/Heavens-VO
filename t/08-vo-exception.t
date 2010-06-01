#!perl -T

use Test::More tests => 3;

use VO::Exception;

my $except = VO::Exception->new("Exception type 1234");

ok(ref($except) eq 'VO::Exception',"Instantiation of VO::Exception.");
ok($except->can('errmsg'),"Class supports errmsg method.");
ok($except->errmsg eq 'Exception type 1234',"Exception message retrieval.");
