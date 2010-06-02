#!/opt/local/bin/perl

package VO::Model;

use strict;
use warnings;

sub new() {
    my $proto = shift;
    my $class = ref($proto) || $proto;
    return bless({} => $class);
}

sub query() {
    my $self = shift;
    print $self,"\n";
}

package main;
sub model($%) {
    my ($class,$params) = @_;
    return $class->new($params);
}





my $m = model('VO::Model',{});

print $m,"\n";

# Template configuration:
use constant VO_TEMPLATE_PATH => '/tmp/templates';
our $VERSION = '0.01';

my $ttconfig = {
    START_TAG => '%__',
    END_TAG => '__%',
    INCLUDE_PATH => $ENV{VO_TEMPLATE_PATH} || VO_TEMPLATE_PATH
};

my $vodata;
my $request;

{
    *_GET_PACKAGE_VERSION = sub () { $VERSION };
    *Apache2::Const::SERVER_ERROR = sub { 1 };
    *Apache2::Const::OK = sub { 0 };
}

sub run_tt() {
    my ($ttconfig) = @_;
    my $tt = Template->new($ttconfig);
    my $votemplate = "voMainResults.tpl";
    
    $tt->process($votemplate, $vodata, $request) || do {
    	$request->log_reason($tt->error());
        return Apache2::Const::SERVER_ERROR();
    };
    
    return Apache2::Const::OK();
}
