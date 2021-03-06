#!perl -T

use Test::More tests => 1;

use VO::Model::WCS;

my ($axis_ra, $axis_dec, $size_ra, $size_dec) = (83.6, 22., 20., 20.);
my $instrument = 'JEMX';

# Create the model and run the search method: this will populate the attributes
# of the class:
my $model = VO::Model::WCS->new({ axis_ra  => $axis_ra,
				  axis_dec => $axis_dec,
				  size_ra  => $size_ra,
				  size_dec => $size_dec,
				  instrument => $instrument });
# Check to see if at least one data member is correct:
ok($model->{size_a} == 20, "WCS model OK.");
