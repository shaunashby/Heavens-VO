#____________________________________________________________________ 
# File: Context.pm
#____________________________________________________________________ 
#  
# Author: Shaun ASHBY <Shaun.Ashby@gmail.com>
# Update: 2010-05-27 13:33:37+0200
# Revision: $Id$ 
#
# Copyright: 2010 (C) Shaun ASHBY
#
#--------------------------------------------------------------------
package VO::Context;

use strict;
use warnings;

sub new() {
    my $proto = shift;
    my $class = ref($proto) || $proto;
    return bless({ stash => {}, errors => [] }, $class);
}

sub stash() { return shift->{stash}; }

sub errors() { return shift->{errors}; } 

sub error() {
    my $self = shift;
    return $#{$self->{errors}} + 1;   
}

sub DESTROY {
    my $self = shift;
    delete $self->{stash};
}

1;

__END__
