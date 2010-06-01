#____________________________________________________________________ 
# File: Provider.pm
#____________________________________________________________________ 
#  
# Author: Shaun ASHBY <Shaun.Ashby@gmail.com>
# Update: 2010-05-26 13:20:45+0200
# Revision: $Id$ 
#
# Copyright: 2010 (C) Shaun ASHBY
#
#--------------------------------------------------------------------
package VO::Provider;

use strict;
use warnings;

use Carp qw(croak);
use IPC::Cmd;

sub new() {
    my $proto = shift;
    my $class = ref($proto) || $proto;
    return bless({ status => 999 },$class);
}

sub register_exe() {
    my $self = shift;
    my $cmd = shift;
    my $fpath;
    
    if ( !($fpath = IPC::Cmd::can_run($cmd)) ) {
	croak(sprintf("Unable to find executable %-s",$cmd));
    }
    
    $self->{provider_exe} = $fpath;
    $self->{provider_env} = shift || {};

    return $self;
}
    
sub status() { return shift->{status}; }

sub stdout() { return shift->{stdout} || []; }

sub stderr() { return shift->{stderr} || []; }

sub run() {
    my ($self, @args) = @_;

    # Set up the environment:
    map {
	$ENV{$_} = $self->{provider_env}->{$_};
    } keys %{ $self->{provider_env} };
    
    my ( $success, $error_code, $full_buf, $stdout_buf, $stderr_buf ) =
	IPC::Cmd::run( command => [ $self->{provider_exe}, @args ] );
    
    if ( !$success ) {
	my ($err) = ($error_code =~ /.*?exited with value (.*?)$/); 
	$self->{status} = $err;
	# All of the output buffers are references to arrays which contain the entire
	# buffer as a single string in the first element. Take this and split it on
	# newlines, then return a new array ref with each line appended with a newline:	
	my $outbuf = [ map { $_."\n" } split(/\n/,$full_buf->[0] ) ];
	# Write to STDERR buffer, scanning for usual ISDC error string:
	$self->{stderr} = [ grep { $_ =~ /Error/ } @$outbuf ];
	$self->{stdout} = $outbuf;
    } else {
	# Set status to 0:
	$self->{status} = 0;
	# Turn off unitialized warnings: either that or we have to check whether in fact there
	# is contents in the out/err buffers...some programs are broken and return only STDOUT,
	# even when there are errors. Sillyness.
	{
	    no warnings 'uninitialized';
	    # Return buffers with correct newlines (corrected array contents):
	    $self->{stdout} = [ map { $_."\n" } split(/\n/,$stdout_buf->[0] ) ];
	    $self->{stderr} = [ map { $_."\n" } split(/\n/,$stderr_buf->[0] ) ];
	}
    }
}

1;

__END__
