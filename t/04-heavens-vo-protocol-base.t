#!perl -T

use Test::More tests => 2;

BEGIN {
    use Heavens::VO::Protocol;
}

my $proto = Heavens::VO::Protocol->new;
ok(ref($proto) eq "Heavens::VO::Protocol","Instantiated OK");

# Check that default protocol is set:
ok($proto->default eq "SIAP","Correct default protocol");
