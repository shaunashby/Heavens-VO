package Heavens::VO::Service;

use warnings;
use strict;
use Carp qw(croak);

our $VERSION = '0.01';

# Base class for services:

sub new() {
    my $proto = shift;
    my $class = ref($proto) || $proto;
    return bless( {} => $class);
}

sub register_command() {
    my ($self,$cmd,$args) = @_;
    do {
	use IPC::Cmd;
	if (!IPC::Cmd::can_run($cmd)) {
	    croak("Unable to find executable \"$cmd\"");
	}
    } if ($cmd && $args);

}

sub run() {
    my ($self, @args) = @_;
    my $cmd = $self->bin_name;
    my $full_path;
    
    if ( !( $full_path = IPC::Cmd::can_run($cmd) ) ) {
	$self->stderr([ qq{couldn't find command '$cmd'} ]);
	$self->status(255);
	return;
    }
    
    @args = $self->cmd_args( @args );

    my ( $success, $error_code, $full_buf, $stdout_buf, $stderr_buf ) =
	IPC::Cmd::run( command => [ $full_path, @args ] );
    
    if ( !$success ) {
	my ($err) = ($error_code =~ /.*?exited with value (.*?)$/); 
	$self->status($err);
	# All of the output buffers are references to arrays which contain the entire
	# buffer as a single string in the first element. Take this and split it on
	# newlines, then return a new array ref with each line appended with a newline:	
	my $outbuf = [ map { $_."\n" } split(/\n/,$full_buf->[0] ) ];
	# Write to STDERR buffer, scanning for usual ISDC error string:
	$self->stderr([ grep { $_ =~ /Error/ } @$outbuf ]);
	$self->stdout($outbuf);
    } else {
	# Turn off unitialized warnings: either that or we have to check whether in fact there
	# is contents in the out/err buffers...some programs are broken and return only STDOUT,
	# even when there are errors. Sillyness.
	{
	    no warnings 'uninitialized';
	    # Return buffers with correct newlines (corrected array contents):
	    $self->stdout([ map { $_."\n" } split(/\n/,$stdout_buf->[0] ) ]);
	    $self->stderr([ map { $_."\n" } split(/\n/,$stderr_buf->[0] ) ]);
	}
    }
}

1;
