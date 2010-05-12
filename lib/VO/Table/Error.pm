#____________________________________________________________________ 
# File: Error.pm
#____________________________________________________________________ 
#  
# Author: Shaun ASHBY <Shaun.Ashby@gmail.com>
# Update: 2010-05-12 16:49:44+0200
# Revision: $Id$ 
#
# Copyright: 2010 (C) Shaun ASHBY
#
#--------------------------------------------------------------------
package VO::Table::Error;

use strict;
use warnings;

sub new() {
    my $proto=shift;
    my $class=ref($proto) || $proto;
    return bless({} => $class);
}

sub render() {
    my $self = shift;
}

1;

__END__
<VOTABLE xmlns="http://www.ivoa.net/xml/VOTable/v1.1" version="1.1">
  <RESOURCE type="results">
  	<INFO name="QUERY_STATUS" value="ERROR">
        errorMessage = [% __errorMessage__ %]
  	</INFO>
  </RESOURCE>
</VOTABLE>
