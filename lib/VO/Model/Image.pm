#____________________________________________________________________ 
# File: Image.pm
#____________________________________________________________________ 
#  
# Author: Shaun Ashby <Shaun.Ashby@gmail.com>
# Update: 2010-05-28 08:27:25+0200
# Revision: $Id$ 
#
# Copyright: 2010 (C) Shaun Ashby
#
#--------------------------------------------------------------------
package VO::Model::Image;

use strict;
use warnings;

use Carp qw(croak);

use VO::Model::WCS;

use constant DEFAULT_RESULT_TYPE => 'image';
use constant DEFAULT_RESULT_IMAGE_TYPE => 'SIGNIFICANCE';

# For file size determination:
use constant IMG_BYTES_PER_PIXEL     => 4;
use constant IMG_BLOCK_SIZE          => 2880;
use constant IMG_HEADER_SIZE_NBLOCKS => 3;

use base 'VO::Model';

sub new() {
    my $proto = shift;
    my $class = ref($proto) || $proto;
    my $params = (@_ == 0) ?             # Error if no params given
 	croak("No params arg given.\n")
 	: (ref($_[0]) eq 'HASH') ? shift
 	: croak("Image model constructor needs a parameter hash ref arg.");

    # Populate the image with the WCS parameters:
    my $self = VO::Model::WCS->new($params)->getData;
    
    # Extract the required image parameters from the params. These
    # are values for which there are no sensible defaults so we
    # expect them to be passed to the constructor.
    for my $att (qw(title bpmodelenergy emin emax instrument)) {
	if (!exists($params->{$att})) {
	    croak("Image must have $att parameter.");
	}
	$self->{$att} = $params->{$att};
    }

    # These parameters have defaults so we only modify them if
    # they are provided as arguments to the constructor:
    if (exists($params->{imagetype})) {
	$self->{imagetype} = $params->{imagetype};
    }
    
    if (exists($params->{bandpass})) {
	$self->{bandpass} = $params->{bandpass};
    }
    
    # Calculate the file size:
    my $img_size_bytes     = $self->{size_a} * $self->{size_b} * IMG_BYTES_PER_PIXEL;
    my $img_size_blocks    = ($img_size_bytes - ($img_size_bytes % IMG_BLOCK_SIZE)) / IMG_BLOCK_SIZE + 1;

    $self->{filesize} = ($img_size_blocks + IMG_HEADER_SIZE_NBLOCKS) * IMG_BLOCK_SIZE;

    return bless($self,$class);
}

sub type() { return shift->{type} || DEFAULT_RESULT_TYPE; }

sub ijd_start() { return shift->{ijd_start} || 0.0; }

sub ijd_end() {  return shift->{ijd_start} || 0.0; }

sub coord_system() { return shift->{coord_system} || 'FK5'; }

sub title() { return shift->{title}; }

sub instrument() { return shift->{instrument}; }

sub filesize() { return shift->{filesize}; }

sub imagetype() { return shift->{imagetype} || DEFAULT_RESULT_IMAGE_TYPE; }

sub bandpass() { return shift->{bandpass} || 'INTEGRAL'; }

sub bpmodelenergy() { return shift->{bpmodelenergy}; }

sub emin() { return shift->{emin}; }

sub emax() { return shift->{emax}; }

1;

__END__

    # Using a protocol module
    # -----------------------

    # my $proto = Protocol::SIAP->new( { attributes => \%atts } );


    # Then in some model where you've got some data from an external source (wcs_pixel_params),

    # $proto->set_attribute_value('BPModalEnergy',123.4);


    # Fields (attributes) listed in the protocol object are rendered in the RESOURCE block of the VO table.
    # These fields are the metadata for the result type of the service:

    # - cutout service result type is 'image'
    # - image type protocol is SIA
    # - easy to specify an extended protocol/restricted protocol to describe exactly what will be rendered in the VO table
    

    # WCS params are required per instrument, same values for all image types. Maybe Image model should inherit from the WCS
    # model (perhaps it's more like an adaptor class in fact..), just passing in the instrument name
    #
    # VO->model('VO::Model::Image',{ instrument => [ i, j ] });
    #
    #


1;

__END__

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
