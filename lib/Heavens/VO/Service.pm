package Heavens::VO::Service;

use warnings;
use strict;

our $VERSION = '0.01';

# Base class for services:

sub new() {
    my $proto = shift;
    my $class = ref($proto) || $proto;
    return bless( {} => $class);
}

1;
