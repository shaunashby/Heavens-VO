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
my $tmpl = '/tmp/vo.tpl';
my $votable = VO::Table->new({ template => $tmpl, context => $ctx });
$votable->process() || die $votable->error;


__END__

# {
#     *_GET_PACKAGE_VERSION = sub () { $VERSION };
#     *Apache2::Const::SERVER_ERROR = sub { 1 };
#     *Apache2::Const::OK = sub { 0 };
# }

# sub run_tt() {
#     my ($ttconfig) = @_;
#     my $tt = Template->new($ttconfig);
#     my $votemplate = "voMainResults.tpl";
    
#     $tt->process($votemplate, $vodata, $request) || do {
#     	$request->log_reason($tt->error());
#         return Apache2::Const::SERVER_ERROR();
#     };
    
#     return Apache2::Const::OK();
# }
