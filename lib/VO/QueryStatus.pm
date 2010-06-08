#____________________________________________________________________ 
# File: QueryStatus.pm
#____________________________________________________________________ 
#  
# Author: Shaun ASHBY <Shaun.Ashby@gmail.com>
# Update: 2010-06-08 15:03:51+0200
# Revision: $Id$ 
#
# Copyright: 2010 (C) Shaun ASHBY
#
#--------------------------------------------------------------------
package VO::QueryStatus;

use strict;
use warnings;

use base qw(Exporter);
use vars qw( @EXPORT_OK %EXPORT_TAGS);

# Context exported as global variable using :context tag:
%EXPORT_TAGS = ( 'common' => [ qw(
OK
ERROR
OVERFLOW
) ] );

@EXPORT_OK = ( @{ $EXPORT_TAGS{'common'} } );

use constant OK => 'OK';
use constant ERROR => 'ERROR';
use constant OVERFLOW => 'OVERFLOW';

1;


1;
__END__
