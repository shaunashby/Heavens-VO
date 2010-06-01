package VO::Table;

use warnings;
use strict;

our $VERSION = '0.01';

# Accepted VO query status flags:
use constant VO_QUERY_STATUS_OK       => 'OK';
use constant VO_QUERY_STATUS_ERROR    => 'ERROR';
use constant VO_QUERY_STATUS_OVERFLOW => 'OVERFLOW';

sub new() {
    my $proto = shift;
    my $class = ref($proto) || $proto;
    return bless(
	{
	    VO_QUERY_STATUS => VO_QUERY_STATUS_OK,
	    VO_PARAMETERS   => {}
	} => $class);
}

sub query_status() {
    my $self = shift;
    @_ ? $self->{VO_QUERY_STATUS} = shift
       : $self->{VO_QUERY_STATUS};
}

sub render() {
    my $self = shift;
    
}

1;
