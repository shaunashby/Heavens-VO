#____________________________________________________________________ 
# File: Image.pm
#____________________________________________________________________ 
#  
# Author: Shaun ASHBY <Shaun.Ashby@gmail.com>
# Update: 2010-06-02 12:58:28+0200
# Revision: $Id$ 
#
# Copyright: 2010 (C) Shaun ASHBY
#
#--------------------------------------------------------------------
package VO::ResultSet::Image;

use strict;
use warnings;

use Carp qw(croak);

use VO;

use base 'VO::ResultSet';

sub new() {
    my $proto = shift;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new(@_);
    return bless($self, $class);
}

sub search() {
    my $self = shift;
    my ($service_config,$params,$opts) = @_;
    
    # Loop over the service context and create objects for the provided images:
    for my $instrument ( keys %{ $service_config->{instruments} } ) {
	for my $img_config ( @{ $service_config->{instruments}->{$instrument} } ) {
	    push(@{$self->{rows}},
		 VO->model($self->model_name,{ %$params,
					       instrument => $instrument,
					       %$img_config, }) );
	}
    }
    return $self;
}

1;

__END__
