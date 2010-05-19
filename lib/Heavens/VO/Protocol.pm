#____________________________________________________________________ 
# File: Protocol.pm
#____________________________________________________________________ 
#  
# Author: Shaun ASHBY <Shaun.Ashby@gmail.com>
# Update: 2010-05-12 15:58:20+0200
# Revision: $Id$ 
#
# Copyright: 2010 (C) Shaun ASHBY
#
#--------------------------------------------------------------------
package Heavens::VO::Protocol;

use strict;
use warnings;

use constant DEFAULT_PROTOCOL => 'SIAP';
use constant PROTOCOL_NAMESPACE => 'Heavens::VO::Protocol';

sub new() {
    my $proto = shift;
    my $class = ref($proto) || $proto;
    return bless({ PROTOCOL => shift || DEFAULT_PROTOCOL } => $class);
}

sub model() {
    my $self = shift;
    my $params = (ref($_[0]) eq 'HASH') ? $_[0] : { $_[0] };
    if (! exists($self->{PROTOCOL_MODEL})) {
	$self->{PROTOCOL_MODEL} = "Heavens::VO::Protocol::".$self->{PROTOCOL};
	$self->{PROTOCOL_MODEL_INSTANCE} = $self->{PROTOCOL_MODEL}->new($params);
    }
    return $self->{PROTOCOL_MODEL_INSTANCE};
}

sub name() { return shift->{PROTOCOL}; }

sub default() { return DEFAULT_PROTOCOL; }

sub parameters() { return shift->{PARAMETERS}; }

1;

__END__
