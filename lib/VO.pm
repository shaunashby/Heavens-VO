#____________________________________________________________________ 
# File: VO.pm
#____________________________________________________________________ 
#  
# Author: Shaun ASHBY <Shaun.Ashby@gmail.com>
# Update: 2010-05-27 12:28:56+0200
# Revision: $Id$ 
#
# Copyright: 2010 (C) Shaun ASHBY
#
#--------------------------------------------------------------------
package VO;

use strict;
use warnings;

use Carp qw(croak);
use VO::Context;

sub model() {
    my ($class,$name) = (shift, shift);
    my $params = (@_ == 0) ?             # Error if no params given
	croak("No params arg given.\n")
	: (ref($_[0]) eq 'HASH') ? shift
	: croak("model() needs a parameter hash ref for $name->new().");
    # Check that the model class inherits from VO::Model
    # Load the model class:
    eval "use $name";
    die __PACKAGE__." - unable to load model class for $name: ".$@."\n", if ($@);
    
    # Instantiate and return the model object:
    return $name->new($params);
}

sub context() {
    my $class = shift;
    return VO::Context->new(@_);
}

1;

__END__
