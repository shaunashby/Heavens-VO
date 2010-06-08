package VO::Table;

use warnings;
use strict;

use Carp qw(croak);

our $VERSION = '0.01';

use Template;

use VO::Config qw(:config);
use VO::QueryStatus;

use overload q{""} => \&render;

sub new() {
    my $proto = shift;
    my $class = ref($proto) || $proto;
    my $self = (@_ == 0) ? # Error if no params given
	croak("No params given.\n")
	: (ref($_[0]) eq 'HASH') ? shift
	: croak("Needs a parameter hash ref");
    
    # Data which will be passed to the template engine:
    $self->{vodata} = {
	query_status => VO::QueryStatus::OK, # Default query status is OK:
	context   => $self->{context} || croak ("VO::Table: no context given as arg."),
    };

    bless($self,$class);
    
    # Template config:
    $self->{tt} = Template->new( {
	INCLUDE_PATH => $ENV{VO_TEMPLATE_DIR} || VO_TEMPLATE_DIR,
     }) || die Template->error(),"\n";

    return $self;
}

sub query_status() {
    my $self = shift;
    @_ ? $self->{vodata}->{query_status} = shift
	: $self->{vodata}->{query_status};
}

sub error() { return sprintf("VO::Table::process: %s\n",shift->{tt}->error()); }

sub render() {
    my $self = shift;
    my $content = '';
    
    # Check for a template:
    if (exists($self->{template})) {
	$self->{tt}->process($self->{template}, $self->{vodata},\$content);
    } else {
	$self->{tt}->process(\*DATA, $self->{vodata},\$content);
    }
    return $content;
}

sub process() {
    my $self = shift;
    my $content = (ref($_[0]) eq 'SCALAR') ? shift : croak("process method takes ref to output variable.");
    $self->{tt}->process(\*DATA, $self->{vodata},$content);
}

1;

__DATA__
QueryStatus: [% query_status %]
[% FOREACH img IN context.resultset.rows %]
[% INCLUDE voentry.tpl %]
[% END %]
