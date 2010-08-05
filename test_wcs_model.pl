#!/opt/local/bin/perl
#____________________________________________________________________ 
# File: test_wcs_model.pl
#____________________________________________________________________ 
#  
# Author: Shaun ASHBY <Shaun.Ashby@gmail.com>
# Update: 2010-06-01 16:32:15+0200
# Revision: $Id$ 
#
# Copyright: 2010 (C) Shaun ASHBY
#
#--------------------------------------------------------------------
use strict;
use warnings;

use VO;
use VO::Config;


my ($axis_ra, $axis_dec, $size_ra, $size_dec) = (228.6, 39.4, 20., 20.);

my $instrument = 'isgri';




my $wcs_data = VO->model('VO::Model::WCS', { axis_ra  => $axis_ra,
					     axis_dec => $axis_dec,
					     size_ra  => $size_ra,
					     size_dec => $size_dec,
					     instrument => $instrument } );

use Data::Dumper; print Dumper($wcs_data);



__DATA__
Axis_A=288.778149
Axis_B=10.919604
Size_A=20
Size_B=20
Scale_A=0.021390
Scale_B=0.021390
CoordRefFrame=FK5
CoordEquinox=2000
CoordProjection=STG
CoordRefPixel_A=-1872.5
CoordRefPixel_B=20.5
CoordRefValue_A=90.000000
CoordRefValue_B=0.000000
CD1_1=-0.0250000000000000
CD1_2=0.0000000000000000
CD2_1=0.0000000000000000
CD2_2=0.0250000000000000
