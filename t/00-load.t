#!perl -T

use Test::More tests => 12;

BEGIN {
    use_ok( 'VO::Config' );
    use_ok( 'VO::Context' );
    use_ok( 'VO::Exception' );
    use_ok( 'VO::Model::Image' );
    use_ok( 'VO::Model::WCS' );
    use_ok( 'VO::Model' );
    use_ok( 'VO::Provider' );
    use_ok( 'VO::Result' );
    use_ok( 'VO::Service::Cutout' );
    use_ok( 'VO::Service' );
    use_ok( 'VO::Table' );
    use_ok( 'VO' );
}

diag( "Testing VO::Service::Cutout $VO::Service::Cutout::VERSION, Perl $], $^X" );

