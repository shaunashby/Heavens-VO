#!perl -T

use Test::More tests => 7;

use VO::Table;

my $votable = VO::Table->new();

ok(ref($votable) eq 'VO::Table',"Instantiation of VO::Table.");
ok($votable->can('query_status'),"Class supports query_status method.");
ok($votable->can('render'),"Class supports render method.");
ok($votable->query_status eq VO::Table::VO_QUERY_STATUS_OK,"query_status method works.");

# Change the query status:
$votable->query_status(VO::Table::VO_QUERY_STATUS_ERROR);

ok($votable->query_status eq VO::Table::VO_QUERY_STATUS_ERROR,"query_status method works after changes.");

isa_ok($votable,'VO::Table');
can_ok($votable,qw(render query_status));
