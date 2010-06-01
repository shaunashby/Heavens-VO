package VO::Service::Cutout;

use warnings;
use strict;

use VO;

use base 'VO::Service';

our $VERSION = '0.01';

use constant DEFAULT_CUTOUT_IMAGE_SIZE => 20;

sub new() {
    my $proto = shift;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new(@_);
    return bless($self, $class);
}

sub image_query() {
    my $self = shift;
    my ($options) = @_;
    
    my ($axis_ra,$axis_dec, $size_ra, $size_dec, $intersects, $format);
    
    if (exists($options->{pos})) {
	# Get RA and DEC of the requested position:
	($axis_ra, $axis_dec) = split(",", $options->{pos});
	# Validate the RA/DEC values:
	if ( (0 >= $axis_ra) || (360 < $axis_ra) ) {
	    $self->error("RA must be in the range 0,360.");
	}
	
	if ( (-90 >= $axis_dec) || (90 <= $axis_dec) ) {
	    $self->error("DEC must be in the range -90,90. ");
	}
    } else {
	# Throw an error: must have position:
	$self->error("Position parameter POS must be provided.");
    }
    
    if (exists($options->{size})) {
	($size_ra, $size_dec) = split(",", $options->{size});
	$size_dec ||= $size_ra; # Same value for both axes if only one given 
    } else {
	# Default size:
	$size_ra = $size_dec = DEFAULT_CUTOUT_IMAGE_SIZE;
    }
	
    # Value of INTERSECTS parameter:
    $intersects = 'OVERLAPS';
    if (exists($options->{intersects}) && $options->{intersects} =~ /COVERS|ENCLOSED|CENTER|OVERLAPS/) {
	# COVERS -- The candidate image covers or includes the entire ROI.
        # ENCLOSED -- The candidate image is entirely enclosed by the ROI. 
        # CENTER -- The candidate image overlaps the center of the ROI. 
        # OVERLAPS -- The candidate image overlaps some part of the ROI.
	$intersects = $options->{intersects};
    }

    # Value of FORMAT parameter:
    $format = 'ALL';
    if (exists($options->{format}) && (
	    $options->{format} =~ m|image/*| || $options->{format} =~ /ALL|GRPAHIC|METADATA/)) {
	#
	# Supported types are
	# - image/fits 
	# - image/png 
	# - image/jpeg 
	# - text/html 
	# In addition, these special values are defined:
	# 
	# ALL      -- Denotes all formats supported by the service. 
	# GRAPHIC  -- Denotes any of the following graphics formats: JPEG, PNG, GIF. These are 
	#             types typically supported "in-line" by web-browsers. 
	# METADATA -- Denotes a Metadata Query: no images are requested; only metadata 
	#             should be returned. This feature is described in more detail in section 6.1. 
	#
	$format = $options->{format};
    }
    
    # Do the search using the model:
    my $resultset = [];
    for my $instrument (qw/ISGRI JEMX/) {
	push(@$resultset,VO->model('VO::Model::Image',{ axis_ra  => $axis_ra,
							axis_dec => $axis_dec,
							size_ra  => $size_ra,
							size_dec => $size_dec,
							instrument => $instrument } )->search() );
    }
}

1;
