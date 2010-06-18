#!perl -T

use Test::More tests => 7;

use VO::Context;
use VO::Table;
use VO::QueryStatus qw(:common);

my $context = VO::Context->new;

# Add a test value to the context:
$context->{value} = 'TEST_IS_OK';

# Path to test template:
$ENV{VO_TEMPLATE_DIR} = './t/templates/tt2';

my $votable = VO::Table->new({ context => $context, template => 'test.tpl' });

ok(ref($votable) eq 'VO::Table',"Instantiation of VO::Table.");
ok($votable->query_status eq OK,"query_status method works.");

# Change the query status:
$votable->query_status(ERROR);

ok($votable->query_status eq ERROR,"query_status method works after changes.");

isa_ok($votable,'VO::Table');
can_ok($votable,qw(process render query_status));

# Test rendering:
ok($votable->render eq "Value: TEST_IS_OK","VOTable direct rendering (using INSTANCE->render) is correct.");
ok("$votable" eq "Value: TEST_IS_OK","VOTable indirect rendering is correct.");
