#____________________________________________________________________ 
# File: Metadata.pm
#____________________________________________________________________ 
#  
# Author: Shaun ASHBY <Shaun.Ashby@gmail.com>
# Update: 2010-05-19 15:13:05+0200
# Revision: $Id$ 
#
# Copyright: 2010 (C) Shaun ASHBY
#
#--------------------------------------------------------------------
package VO::Metadata;

use strict;
use warnings;

use Carp qw(croak);

sub new() {
    my $proto = shift;
    my $class = ref($proto) || $proto;
    my $self = (@_ == 0) ?               # Error if no params given
	croak("No params given.\n")
	: (ref($_[0]) eq 'HASH') ? $_[0] # Got hashref already - OK
	: { @_ };                        # Otherwise, store the params in a hash
    # Simple validation: must have name, datatype and description
    map { exists($self->{$_}) || croak "Field must have attribute $_" } qw(name datatype description);
    return bless($self => $class);
}

1;

__END__
