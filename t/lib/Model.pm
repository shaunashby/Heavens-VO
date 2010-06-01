package Model;

use strict;
use warnings;

sub new() {
	my $proto = shift;
	my $class = ref($proto) || $proto;
	return bless({}, $class);
}

1;
