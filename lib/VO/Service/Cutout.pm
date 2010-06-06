package VO::Service::Cutout;

use warnings;
use strict;

use VO;

use base 'VO::Service';

use VO::ResultSet::Image;

our $VERSION = '0.01';

use constant DEFAULT_CUTOUT_IMAGE_SIZE => 20;
use constant DEFAULT_CUTOUT_IMAGE_MAX_SIZE => 40;

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
	    $self->error("DEC must be in the range -90,90.");
	}
    } else {
	# Throw an error: must have position:
	$self->error("Position parameter POS must be provided.");
    }
    
    if (exists($options->{size})) {
	($size_ra, $size_dec) = split(",", $options->{size});
	$size_dec ||= $size_ra; # Same value for both axes if only one given
	# Check to make sure that the size parameter is within limits for the service:
	if ($size_ra > DEFAULT_CUTOUT_IMAGE_MAX_SIZE || $size_dec > DEFAULT_CUTOUT_IMAGE_MAX_SIZE) {
	    $self->error("SIZE exceeds maximum allowed image size.");
	}
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
    
    # Do the search using a ResultSet to access data and return model objects. Display results for the image
    # configuration we specify in the service definition (service.yml) which will be read by the VO::Service base class
    # and stored in the service_config attribute within the context. Access this using the config() method:
    my $resultset = VO::ResultSet::Image->new('VO::Model::Image');

    # Either return the ResultSet or store it in the context?
    return $resultset->search($self->config,{ axis_ra  => $axis_ra,
					      axis_dec => $axis_dec,
					      size_ra  => $size_ra,
					      size_dec => $size_dec, });
}

1;
