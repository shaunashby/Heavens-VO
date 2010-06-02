#____________________________________________________________________ 
# File: Service.pm
#____________________________________________________________________ 
#  
# Author: Shaun ASHBY <Shaun.Ashby@gmail.com>
# Update: 2010-05-26 12:40:54+0200
# Revision: $Id$ 
#
# Copyright: 2010 (C) Shaun ASHBY
#
#--------------------------------------------------------------------
package VO::Service;

use strict;
use warnings;

use Carp qw(croak);
use YAML::Syck qw(Load);
use Path::Class::File;

use VO::Config qw(:config);
use VO::Exception;

sub new() {
    my $proto = shift;
    my $class = ref($proto) || $proto;
    my $self = (@_ == 0) ?        # Error if no params given
	croak("No params given.\n")
	: (ref($_[0]) eq 'HASH') ?
	($_[0]->{context} && ref($_[0]->{context}) eq 'VO::Context') ? shift
	: croak("context parameter with VO::Context object required.")
	: croak("Needs a parameter hash ref.");

    # Read the service configuration and connect it to the service:
    $self->{service_config} = Load(Path::Class::File->new(HEAVENS_SERVICE_CONFIG_FILE)->slurp);

    return bless($self,$class);
}

sub config() { return shift->{service_config}; }

sub error() {
    my $self = shift;
    my ($errmsg) = @_;
    push(@{ $self->{context}->{errors} }, VO::Exception->new({ errmsg => $errmsg }));
}

sub status() { return $#{ shift->{context}->{errors} } + 1; }

1;

__END__
