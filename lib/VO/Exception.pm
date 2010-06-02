#____________________________________________________________________ 
# File: Exception.pm
#____________________________________________________________________ 
#  
# Author: Shaun ASHBY <Shaun.Ashby@gmail.com>
# Update: 2010-05-28 17:00:23+0200
# Revision: $Id$ 
#
# Copyright: 2010 (C) Shaun ASHBY
#
#--------------------------------------------------------------------
package VO::Exception;

use strict;
use warnings;

sub new() {
    my $proto = shift;
    my $class = ref($proto) || $proto;
    return bless({ what => shift }, $class);
}

sub what() { return shift->{what}; }

1;

__END__
