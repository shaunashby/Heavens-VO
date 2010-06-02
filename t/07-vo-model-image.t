#!perl -T

use Test::More tests => 1;

use VO::Model::Image;

# Create the model and run the search method: this will populate the attributes
# of the class:

my $model = VO::Model::Image->new();

ok($model->can('search'),"Search method is defined.");
