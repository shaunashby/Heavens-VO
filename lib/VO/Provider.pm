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
use Config;

use mod_perl2;
use constant MP2 => (exists($ENV{MOD_PERL_API_VERSION}) and $ENV{MOD_PERL_API_VERSION} >= 2 );
use constant PERLIO_IS_ENABLED => $Config{useperlio};

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
    # If we're in a mod_perl2 environment then run using subprocess within Apache
    # otherwise just use IPC::Cmd:
    if (MP2) {
	$self->subprocess_run(@args);
    } else {
	$self->ipc_run(@args);
    }
}

sub subprocess_run() {
    my ($self, @args) = @_;
    my ($in_fh, $out_fh, $err_fh);
    
    use Apache2::RequestUtil;
    use Apache2::SubProcess;
    
    # Retrieve the request object:
    my $req = Apache2::RequestUtil->request;

    # Set up the environment:
    map {
	$req->subprocess_env->set( $_ => $self->{provider_env}->{$_} );
    } keys %{ $self->{provider_env} };
    
    # If there are args:
    if ($#args) {
	($in_fh, $out_fh, $err_fh) = $req->spawn_proc_prog($self->{provider_exe},[ @args ]);
    } else {
	($in_fh, $out_fh, $err_fh) = $req->spawn_proc_prog($self->{provider_exe});
    }

    # Read the output data:
    my $data;
    if (PERLIO_IS_ENABLED || IO::Select->new($out_fh)->can_read(10)) {
	$data = [ <$out_fh> ];
	$self->{stdout} = [];
	map {
	    chomp(my ($str) = $_);
	    push(@{ $self->{stdout} },$str);
	} @$data;
	$self->{status} = 0;
    }

    # Read the error output:
    if (PERLIO_IS_ENABLED || IO::Select->new($err_fh)->can_read(10)) {
	$data = [ <$err_fh> ];
	$self->{stderr} = [];
	map {
	    chomp(my ($str) = $_);
	    push(@{ $self->{stderr} },$str);
	} @$data;
	$self->{status} = $#{ $self->{stderr} } + 1;
    }
}

sub ipc_run() {
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
