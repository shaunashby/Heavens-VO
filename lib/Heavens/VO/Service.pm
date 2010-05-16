package Heavens::VO::Service;

use warnings;
use strict;
use Carp qw(croak);

our $VERSION = '0.01';

# Base class for services:

sub new() {
    my $proto = shift;
    my $class = ref($proto) || $proto;
    return bless( {} => $class);
}

sub register_command() {
    my ($self,$cmd,$args) = @_;
    do {
	use IPC::Cmd;
	if (!IPC::Cmd::can_run($cmd)) {
	    croak("Unable to find executable \"$cmd\"");
	}
    } if ($cmd && $args);

}

1;
