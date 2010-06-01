package VO::Result;

use warnings;
use strict;

use Carp qw(croak);

use constant DEFAULT_RESULT_TYPE => 'image';
use constant DEFAULT_RESULT_IMAGE_TYPE => 'SIGNIFICANCE';

sub new() {
    my $proto = shift;
    my $class = ref($proto) || $proto;
    my $self = (@_ == 0) ?             # Error if no params given
	croak("No params arg given.\n")
	: (ref($_[0]) eq 'HASH') ? shift
	: croak("Result class needs a parameter hash ref arg.");
    return bless($self,$class);
}

sub type() { return shift->{type} || DEFAULT_RESULT_TYPE; }

sub ijd_start() { return shift->{ijd_start} || 0.0; }

sub ijd_end() {  return shift->{ijd_start} || 0.0; }

sub coord_system() { return shift->{coord_system} || 'FK5'; }

sub title() { return shift->{title}; }

sub instrument() { return shift->{instrument}; }

sub imagetype() { return shift->{imagetype} || DEFAULT_RESULT_IMAGE_TYPE; }

sub bandpass() { return shift->{bandpass}; }

sub bpmodelenergy() { return shift->{bpmodelenergy}; }

sub emin() { return shift->{emin}; }

sub emax() { return shift->{emax}; }

1;

__END__
  # @{$_[0]} = (
  #   {
  #     Title         => "17.8-80.0 keV ISGRI significance image",
  #     Instrument    => "ISGRI",
  #     ImageType     => "SIGNIFICANCE",
  #     Bandpass      => "INTEGRAL",
  #     BPModelEnergy => "48.648",
  #     Emin          => "17.278",
  #     Emax          => "80.018",
  #   },
  #   {
  #     Title         => "80.0-250 keV ISGRI significance image",
  #     Instrument    => "ISGRI",
  #     ImageType     => "SIGNIFICANCE",
  #     Bandpass      => "INTEGRAL",
  #     BPModelEnergy => "164.98725",
  #     Emin          => "80.018",
  #     Emax          => "249.9565",
  #   },
  #   {
  #     Title         => "3.0-10.2 keV JEM-X significance image",
  #     Instrument    => "JEMX",
  #     ImageType     => "SIGNIFICANCE",
  #     Bandpass      => "INTEGRAL",
  #     BPModelEnergy => "6.64",
  #     Emin          => "3.04",
  #     Emax          => "10.24",
  #   },
  #   {
  #     Title         => "10.2-34.9 keV JEM-X significance image",
  #     Instrument    => "JEMX",
  #     ImageType     => "SIGNIFICANCE",
  #     Bandpass      => "INTEGRAL",
  #     BPModelEnergy => "22.56",
  #     Emin          => "10.24",
  #     Emax          => "34.88",
  #   },
  # );


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
