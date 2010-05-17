#____________________________________________________________________ 
# File: Cutout.pm
#____________________________________________________________________ 
#  
# Author: Shaun Ashby <Shaun.Ashby@gmail.com>
# Update: 2010-05-16 22:36:36+0200
# Revision: $Id$ 
#
# Copyright: 2010 (C) Shaun Ashby
#
#--------------------------------------------------------------------
package Heavens::VO::Service::Cutout;

our @ISA = ('Heavens::VO::Service');

use constant SERVICE_EXECUTABLE => 'wcs_pixels_params';

sub new(){
    my $proto = shift;
    my $class = ref($proto) || $proto;
    my $self = bless({} => $class);
    $self->SUPER::register_command(SERVICE_EXECUTABLE,"");
    return $self;
}


1;

__END__
