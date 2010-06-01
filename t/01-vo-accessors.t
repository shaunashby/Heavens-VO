#!perl -T

my @atts = qw(a1 a2);

use Test::More tests => 2;

use VO;

my $model = VO->model('VO::Model',{ attributes => \@atts });
ok(ref($model) eq 'VO::Model',"Model instantiation from VO class.");

my $context = VO->context;
ok(ref($context) eq 'VO::Context',"Context instantiation from VO class.");
