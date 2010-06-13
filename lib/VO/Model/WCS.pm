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
use VO::Provider;

use Carp qw(croak);

our @required_attribute_names = qw/
axis_a
axis_b
size_a
size_b
scale_a
scale_b
coordrefframe
coordequinox
coordprojection
coordrefpixel_a
coordrefpixel_b
coordrefvalue_a
coordrefvalue_b
cd1_1
cd1_2
cd2_1
cd2_2
/;

use constant BASEDIR_FMT    => "BaseDir=%s";
use constant INSTRUMENT_FMT => "Instrument=%s";
use constant A_RA_FMT       => "Axis_RA=%f";
use constant A_DEC_FMT      => "Axis_DEC=%f";
use constant SZ_RA_FMT      => "Size_RA=%f";
use constant SZ_DEC_FMT     => "Size_DEC=%f";

sub new() {
    my $proto = shift;
    my $class = ref($proto) || $proto;
    my $params = (@_ == 0) ?             # Error if no params given
	croak("No params arg given.") :  (ref($_[0]) eq 'HASH') ? shift
	: croak("WCS model requires hash of parameters for the wrapped executable.");
    
    for my $required qw(instrument axis_ra axis_dec size_ra size_dec) {
	if (!$params->{$required}) {
	    croak("WCS model requires $required parameter");
	}
    }

    my $self = { provider => VO::Provider->new()->register_exe(VO_PROVIDER_WCS_EXE,{ COMMONSCRIPT => 1,
										     PFILES => VO_PROVIDER_WCS_PFILES_PATH
							       } )};
    # Add the list of args for wcs_pixel_params executable:
    $self->{args} = [ sprintf(BASEDIR_FMT,HEAVENS_ARCHIVE_DIR),
		      sprintf(INSTRUMENT_FMT,$params->{instrument}),
		      sprintf(A_RA_FMT,$params->{axis_ra}),
		      sprintf(A_DEC_FMT,$params->{axis_dec}),
		      sprintf(SZ_RA_FMT,$params->{size_ra}),
		      sprintf(SZ_DEC_FMT,$params->{size_dec}) ];
    
    return bless($self, $class);
}

sub getData() {
    my ($self) = @_;
    $self->{wcs_data} = {}, if (!exists($self->{wcs_data}));
    # Return some dummy results if under test mode (executable doesn't run properly under test_harness):
    if ($ENV{WCS_TEST_MODE}) {
	return $self->{wcs_data} = {
	    cd1_1 => 1000.,
	    cd1_2 => 1000.,
	    cd2_1 => 1000.,
	    cd2_2 => 1000,
	    size_a => 20.,
	    size_b => 20.,
	};
    }
    # Normal running:
    $self->{provider}->run( @{ $self->{args} } );
    # Store the data for the WCS attributes:
    map { chomp; my ($param,$value) = split("=",$_); $self->{wcs_data}->{lc($param)} = $value; } @{$self->{provider}->stdout};
    # Check that the required attributes exist in the object:
    for my $att (@required_attribute_names) {
	croak("Model::WCS: ERROR in running executable for WCS - $att not found in object attributes.")
	    unless (exists $self->{wcs_data}->{$att});
    }
    # Return the WCS data:
    return $self->{wcs_data};
}

1;
