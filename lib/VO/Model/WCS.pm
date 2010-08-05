#____________________________________________________________________ 
# File: WCS.pm
#____________________________________________________________________ 
#  
# Author: Shaun ASHBY <Shaun.Ashby@gmail.com>
# Update: 2010-05-26 16:43:29+0200
# Revision: $Id$ 
#
# Copyright: 2010 (C) Shaun ASHBY
#
#--------------------------------------------------------------------
package VO::Model::WCS;

use strict;
use warnings;

use VO::Config qw(:config);

use Pixel::WCS;

use Carp qw(croak);

sub new() {
    my $proto = shift;
    my $class = ref($proto) || $proto;
    my $params = (@_ == 0) ?             # Error if no params given
	croak("No params arg given.") :  (ref($_[0]) eq 'HASH') ? shift
	: croak("WCS model requires hash of parameters.");
    
    for my $required qw(instrument axis_ra axis_dec size_ra size_dec) {
	if (!$params->{$required}) {
	    croak("WCS model requires $required parameter");
	}
    }
    
    my $coordsystem = 'FK5';
    my $pxwcs = Pixel::WCS::WCS->new(HEAVENS_ARCHIVE_DIR, $params->{instrument});

    $pxwcs->search($params->{axis_ra},
		   $params->{axis_dec}, $coordsystem,
		   $params->{size_ra},
		   $params->{size_dec});
    
    my $imgparams = $pxwcs->params();
    
    # Now copy the data:
    my $self = {
	axis_a          => $imgparams->ra(),
	axis_b          => $imgparams->dec(),
	size_a          => $imgparams->size_x(),
	size_b          => $imgparams->size_y(),
	scale_a         => $imgparams->scaleA(),
	scale_b         => $imgparams->scaleB(),	
	coordrefframe   => $imgparams->coordrefframe(),
	coordequinox    => $imgparams->coordequinox(),
	coordprojection => $imgparams->coordprojection(),
	coordrefpixel_a => $imgparams->coordrefpixelA(),
	coordrefpixel_b => $imgparams->coordrefpixelB(),
	coordrefvalue_a => $imgparams->coordrefvalueA(),
	coordrefvalue_b => $imgparams->coordrefvalueB(),
	cd1_1           => $imgparams->cd()->get(0),
	cd1_2           => $imgparams->cd()->get(1),
	cd2_1           => $imgparams->cd()->get(2),
	cd2_2           => $imgparams->cd()->get(3)
    };
    
    # Clean up:
    undef $imgparams;
    undef $pxwcs;
    
    return bless($self, $class);
}

1;
