#!perl -T

use Test::More tests => 5;

use VO::Context;
use VO::Table;
use VO::QueryStatus qw(:common);

my $context = VO::Context->new;
my $votable = VO::Table->new({ context => $context });

ok(ref($votable) eq 'VO::Table',"Instantiation of VO::Table.");
ok($votable->query_status eq OK,"query_status method works.");

# Change the query status:
$votable->query_status(ERROR);

ok($votable->query_status eq ERROR,"query_status method works after changes.");

isa_ok($votable,'VO::Table');
can_ok($votable,qw(render query_status));
