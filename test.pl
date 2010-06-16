#!/opt/local/bin/perl

use VO::Service::Cutout;
use VO::Context;
use VO::Table;

$ENV{WCS_TEST_MODE} = 0; # = 1 for test mode, meaning only cd_x_y params will be set to 1000.

my $ctx = VO::Context->new;
my $cs = VO::Service::Cutout->new({ context => $ctx });

my $POS    = "299.6,+35.2"; # Good values
my $SIZE   = "20,20";
my $FORMAT = "image%2Ffits";
my $INTERSECT = 'OVERLAPS';

$cs->image_query( { pos    => $POS,
		    size   => $SIZE,
		    format => $FORMAT,
                    intersect => $INTERSECT } );

if ($cs->status) {
    map { print $_->what."\n"; } @{ $ctx->errors };
}

# Render test:
my $votable = VO::Table->new({ template => 'votable.tpl', context => $ctx });
my $output = '';

$votable->process(\$output) || die $votable->error;

print $output,"\n";
print "$votable","\n";

__END__

# {
#     *_GET_PACKAGE_VERSION = sub () { $VERSION };
#     *Apache2::Const::SERVER_ERROR = sub { 1 };
#     *Apache2::Const::OK = sub { 0 };
# }
