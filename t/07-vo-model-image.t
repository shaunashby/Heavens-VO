#!perl -T

use Test::More tests => 2;

use VO::Model::Image;

$ENV{WCS_TEST_MODE} = 1; # don't actually run the wcs executable since it hangs under test_harness.

# Create the model and run the search method: this will populate the attributes
# of the class:
my ($axis_ra, $axis_dec, $size_ra, $size_dec) = (83.6, 22., 20., 20.);
my $instrument = 'ISGRI';

my $service_config = {
    title         => "17.8-80.0 keV ISGRI significance image",
    instrument    => "ISGRI",
    imagetype     => "SIGNIFICANCE",
    bandpass      => "INTEGRAL",
    bpmodelenergy => "48.648",
    emin          => "17.278",
    emax          => "80.018",
};

# Create the model and run the search method: this will populate the attributes
# of the class:
my $model1 = VO::Model::Image->new({ axis_ra  => $axis_ra,
				     axis_dec => $axis_dec,
				     size_ra  => $size_ra,
				     size_dec => $size_dec,
				     instrument => $service_config->{instrument},
				     title      => $service_config->{title},
				     imagetype  => $service_config->{imagetype},
				     bandpass   => $service_config->{bandpass},
				     bpmodelenergy => $service_config->{bpmodelenergy},
				     emin          => $service_config->{emin},
				     emax          => $service_config->{emax},
				   });

# Test instantiation with all parameters user-supplied:
ok(ref($model1) eq 'VO::Model::Image',"Instantiation works (all parameters).");

# Test instantiation with defaults (no imagetype/bandpass):
my $model2 = VO::Model::Image->new({ axis_ra  => $axis_ra,
				     axis_dec => $axis_dec,
				     size_ra  => $size_ra,
				     size_dec => $size_dec,
				     instrument => $service_config->{instrument},
				     title      => $service_config->{title},
				     bpmodelenergy => $service_config->{bpmodelenergy},
				     emin          => $service_config->{emin},
				     emax          => $service_config->{emax},
				   });

ok(ref($model2) eq 'VO::Model::Image',"Instantiation works (default parameters).");
