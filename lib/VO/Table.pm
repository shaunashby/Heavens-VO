package VO::Table;

use warnings;
use strict;

our $VERSION = '0.01';

# Accepted VO query status flags:
use constant VO_QUERY_STATUS_OK       => 'OK';
use constant VO_QUERY_STATUS_ERROR    => 'ERROR';
use constant VO_QUERY_STATUS_OVERFLOW => 'OVERFLOW';

use Template;

use VO::Config qw(:config);

use overload q{""} => \&render();

sub new() {
    my $proto = shift;
    my $class = ref($proto) || $proto;
    my $self = (@_ == 0) ? # Error if no params given
	croak("No params given.\n")
	: (ref($_[0]) eq 'HASH') ? shift
	: croak("Needs a parameter hash ref");

    $self->{VO_QUERY_STATUS} = VO_QUERY_STATUS_OK;
    $self->{VO_PARAMETERS} = {};
    
    $self->{vodata} = {
	voentries => $self->{voentries},
    };
    
    # TT config:
    $self->{tt} = Template->new(
	config => {
	    START_TAG => '[%',
	    END_TAG => '%]',
	    INCLUDE_PATH => $ENV{VO_TEMPLATE_PATH} || VO_TEMPLATE_PATH,
	});
    return bless($self,$class);
}

sub voentries { return shift->{entries}; }

sub query_status() {
    my $self = shift;
    @_ ? $self->{VO_QUERY_STATUS} = shift
       : $self->{VO_QUERY_STATUS};
}

sub render() {
    my $self = shift;
}

sub write() {
    my $self = shift;
    my $output = shift || '';
    $self->{tt}->process(\*DATA, $self->{data},$output) || die $self->{tt}->error();
}

1;

__DATA__
[% FOREACH voentry IN voentries %]
[% PROCESS voentry %]
[% END %]
