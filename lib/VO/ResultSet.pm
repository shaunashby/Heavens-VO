#____________________________________________________________________ 
# File: ResultSet.pm
#____________________________________________________________________ 
#  
# Author: Shaun ASHBY <Shaun.Ashby@gmail.com>
# Update: 2010-06-02 12:09:09+0200
# Revision: $Id$ 
#
# Copyright: 2010 (C) Shaun ASHBY
#
#--------------------------------------------------------------------
package VO::ResultSet;

use strict;
use warnings;

use Carp qw(croak);

sub new() {
    my $proto = shift;
    my $class = ref($proto) || $proto;
    my $model = (@_ == 0) ?
	croak("First argument to ResultSet must be a model name.")
	: ($model =~ /VO::Model/) ? shift
	: croak("Model is not in the VO::Model namespace.");  
    return bless({ model_name => $model, rows => [], nrows => sub { return $#${ shift->{rows} + 1 } } }, $class);    
}

sub search() { croak("ResultSet search() method must be overriden in sub-classes."); }

sub model_name() { return shift->{model_name}; }

sub rows() { return shift->{rows}; }

1;

__END__
