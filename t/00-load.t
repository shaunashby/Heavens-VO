#!perl -T

use Test::More tests => 5;

BEGIN {
	use_ok( 'Heavens::VO' );
	use_ok( 'Heavens::VO::Service' );
	use_ok( 'Heavens::Config' );
	use_ok( 'VO::Table' );
	use_ok( 'VO::Table::Error' );
}

diag( "Testing Heavens::VO $Heavens::VO::VERSION, Perl $], $^X" );
