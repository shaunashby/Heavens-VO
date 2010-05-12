#!perl -T

use Test::More tests => 2;

BEGIN {
    use VO::Table;
    use VO::Table::Error;
}

my $votable = VO::Table->new;
ok(ref($votable) eq "VO::Table","Instantiated OK");

my $error = VO::Table::Error->new;
ok(ref($error) eq "VO::Table::Error","Instantiated OK");
