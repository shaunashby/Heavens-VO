#!/opt/local/bin/perl

use VO::Service::Cutout;
use VO::Context;
use VO::Table;

my $ctx = VO::Context->new;
my $cs = VO::Service::Cutout->new({ context => $ctx });

my $POS    = "299.59,+35.2"; # Good values
my $SIZE   = "20,20";
my $FORMAT = "image%2Ffits";
my $INTERSECT = 'OVERLAPS';

print "\n";

$cs->image_query( { pos    => $POS,
		    size   => $SIZE,
		    format => $FORMAT,
                    intersect => $INTERSECT } );

if ($cs->status) {
print "\n\n--- Dumping errors ---\n";
    map { printf("VO::QueryStatus::%s -- %s\n", $_->type,$_->what); } @{ $ctx->errors };
print "------------\n\n";
}

# Render test:
my $votable = VO::Table->new({ template => 'votable.tpl', context => $ctx });
my $output = '';

$votable->process(\$output) || die $votable->error;

print "=============== Directly printing the output string ================\n";
print $output,"\n";
print "================ Printing with overloaded string op calling render ============\n";
print "$votable","\n";

