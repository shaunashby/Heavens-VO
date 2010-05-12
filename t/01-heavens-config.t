#!perl -T

use Test::More tests => 1;

BEGIN {
    use Heavens::Config qw(:config);
}

ok(HEAVENS_BASE eq '@@HEAVENS_BASE@@',"HEAVENS_BASE correct");
