#!perl -T

use Test::More tests => 1;

BEGIN {
    use Heavens::VO::Service qw(:context);
}

my $service = Heavens::VO::Service->new;
ok(ref($service) eq "Heavens::VO::Service","Instantiated OK");

