#____________________________________________________________________ 
# File: Model.pm
#____________________________________________________________________ 
#  
# Author: Shaun ASHBY <Shaun.Ashby@gmail.com>
# Update: 2010-05-28 16:37:33+0200
# Revision: $Id$ 
#
# Copyright: 2010 (C) Shaun ASHBY
#
#--------------------------------------------------------------------
package VO::Model;

use strict;
use warnings;

use Carp qw(croak);

sub new() {
    my $proto = shift;
    my $class = ref($proto) || $proto;
    my $self = (@_ == 0) ?             # Error if no params given
	croak("No params arg given.\n")
	: (ref($_[0]) eq 'HASH') ? shift : {};
    
    if (exists($self->{attributes}) && ref($self->{attributes}) eq 'ARRAY') {
	map {
	    $self->{$_} = "";
	} @{ $self->{attributes} };
    } else {
	$self->{attributes} = [];
    }
    
    return bless($self, $class);
}

sub search { return []; }

sub get() {
    my $self = shift;
    my ($attribute_name) = @_;
    return $self->{$attribute_name} if ($self->{$attribute_name});
}

# sub provider() { return shift->{provider}; }

# sub _get_data_from_provider() { croak("_get_data_from_provider() must be overridden in sub-class."); }

sub attributes() { return shift->{attributes}; }

1;

__END__
