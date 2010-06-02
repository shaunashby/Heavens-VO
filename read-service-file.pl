#!/opt/local/bin/perl
#____________________________________________________________________ 
# File: read-service-file.pl
#____________________________________________________________________ 
#  
# Author: Shaun ASHBY <Shaun.Ashby@gmail.com>
# Update: 2010-06-01 11:59:50+0200
# Revision: $Id$ 
#
# Copyright: 2010 (C) Shaun ASHBY
#
#--------------------------------------------------------------------

package Image;

use strict;
use warnings;
use Carp qw(croak);

sub new() {
    my $proto = shift;
    my $class = ref($proto) || $proto;
    my $self = (@_ == 0) ?             # Error if no params given
	croak("No params arg given.")
	: (ref($_[0]) eq 'HASH' && exists($_[0]->{image_config}) ) ? shift->{image_config} : {};
    return bless($self, $class);
}

use VO;

use YAML::Syck qw(Load);
use Path::Class::File;

my $service=Path::Class::File->new("./service.yml")->slurp;
my $service_config= Load($service);

my ($axis_ra, $axis_dec, $size_ra, $size_dec) = (83.6, 22., 20., 20.);

use Data::Dumper;

map {
    my $image = Image->new( { image_config => $_ });
    print Dumper($image),"\n";
} @{ $service_config->{instruments}->{isgri}->{images} };

# Loop over the service context and create objects for the provided images:
my $images = [];
my $params = { axis_ra  => $axis_ra,
	       axis_dec => $axis_dec,
	       size_ra  => $size_ra,
	       size_dec => $size_dec, };

for my $instrument ( keys %{ $service_config->{instruments} } ) {
    for my $img ( @{ $service_config->{instruments}->{$instrument}->{images} } ) {
	push(@$images, VO->model('VO::Model::Image', { instrument => $instrument, %$params, %$img, } ));
    }
}

print Dumper($images),"\n";
