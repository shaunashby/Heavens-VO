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

sub new() {
    my $proto = shift;
    my $class = ref($proto) || $proto;
    return bless({} => $class);
}

sub default() { return DEFAULT_PROTOCOL; }

1;
__END__
