#____________________________________________________________________ 
# File: Handler.pm
#____________________________________________________________________ 
#  
# Author: Shaun ASHBY <Shaun.Ashby@gmail.com>
# Update: 2010-05-27 13:57:26+0200
# Revision: $Id$ 
#
# Copyright: 2010 (C) Shaun ASHBY
#
#--------------------------------------------------------------------
package VO::Service::Cutout::Handler;

use strict;
use warnings;

use Apache2::RequestRec ();
use APR::Request::Apache2 ();

use Apache2::Const -compile => qw(DECLINED OK);

use VO::Model;
use VO::Context;

sub handler() {
    my $r = shift;
    
    # Only allow GET requests:
    return Apache2::Const::DECLINED unless $r->method eq 'GET';

    # This is required to get access to the parameters:
    my $apreq = APR::Request::Apache2->handle($r);

    my $POS = $apreq->param('pos');
    my $SIZE = $apreq->param('size');
    my $FORMAT = $apreq->param('format');
    my $INTERSECT = $apreq->param('intersect');
    
    my $context = VO->context;
    $context->stash->{request_time} = $r->request_time();
    
    my $service = VO::Service::Cutout->new( { context => $context } );
    
    $service->image_query( { pos    => $POS,
			     size   => $SIZE,
			     format => $FORMAT,
                             intersect => $INTERSECT } );    

    my $votable = VO::Table->new($context);

    return Apache2::Const::OK;
}

1;

__END__
