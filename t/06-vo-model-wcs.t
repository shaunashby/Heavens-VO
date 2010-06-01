#!perl -T

use Test::More tests => 6;

use VO::Model::WCS;

# Create the model and run the search method: this will populate the attributes
# of the class:
my $model = VO::Model::WCS->new();
ok($model->can('search'),"Search method is defined.");

$model->search({});

ok($model->can('get'),"Get method is defined.");
#ok($model->get("coordrefframe") eq "FK5","Model get method works.");

my $attributes = $model->attributes();
ok(ref($attributes) eq 'ARRAY',"Attributes array valid.");
ok($#$attributes == 16,"Correct number of attributes.");

ok(defined($model->provider() ),"WCS provider exists.");
