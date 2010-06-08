package VO::Table;

use warnings;
use strict;

use Carp qw(croak);

our $VERSION = '0.01';

use Template;

use VO::Config qw(:config);
use VO::QueryStatus;

#use overload q{""} => \&render;

sub new() {
    my $proto = shift;
    my $class = ref($proto) || $proto;
    my $self = (@_ == 0) ? # Error if no params given
	croak("No params given.\n")
	: (ref($_[0]) eq 'HASH') ? shift
	: croak("Needs a parameter hash ref");

    # Check for a template:
    if (!exists($self->{template})) {
	croak("No template given as arg.");
    }
    
    # Data which will be passed to the template engine:
    $self->{vodata} = {
	query_status => VO::QueryStatus::OK, # Default query status is OK:
	context   => $self->{context} || croak ("VO::Table: no context given as arg."),
    };

    bless($self,$class);
    
    # Template config:
    $self->{tt} = Template->new( {
	START_TAG => '[%',
	END_TAG => '%]',
	ABSOLUTE => 1,
	INCLUDE_PATH => $ENV{VO_TEMPLATE_DIR} || VO_TEMPLATE_DIR,
     }) || die Template->error(),"\n";

    return $self;
}

sub query_status() {
    my $self = shift;
    @_ ? $self->{vodata}->{query_status} = shift
	: $self->{vodata}->{query_status};
}

sub render() {
    my $self = shift;
}

sub error() { return sprintf("VO::Table::process: %s\n",shift->{tt}->error()); }

sub process() {
    my $self = shift;
    my $output = shift || '/tmp/crap.out';
    my $crap = {
	query_status => 'dfdfddfdf',
    };
    $self->{tt}->process($self->{template},$crap,$output);
}

1;
