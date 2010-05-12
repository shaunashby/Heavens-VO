#!perl -T

use Test::More tests => 1;

BEGIN {
    use Heavens::Config qw(:context);
}

ok($context->base eq '@@HEAVENS_BASE@@',"HEAVENS_BASE correct");

