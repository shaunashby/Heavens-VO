#!perl -T

use Test::More tests => 7;

use VO::Model::Image;

# Create the model and run the search method: this will populate the attributes
# of the class:
my $model = VO::Model::Image->new();
ok($model->isa('VO::Model::WCS'),"Image model ISA VO::Model::WCS.");
ok($model->can('search'),"Search method is defined.");

$model->search({ axis_ra  => $axis_ra,
		 axis_dec => $axis_dec,
		 size_ra  => $size_ra,
		 size_dec => $size_dec,
		 instrument => $instrument,
		 format   => $format,
                 intersects => $intersects }););

ok($model->can('get'),"Get method is defined.");
#ok($model->get("coordrefframe") eq "FK5","Model get method works.");

my $attributes = $model->attributes();
ok(ref($attributes) eq 'ARRAY',"Attributes array valid.");
ok($#$attributes == 16,"Correct number of attributes.");

ok(defined($model->provider() ),"WCS provider exists.");
