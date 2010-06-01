#!perl -T

use Test::More tests => 4;

use constant TEST_PROVIDER_EXE => 'echo';

use VO::Model;
use VO::Provider;

my $model = VO::Model->new({ attributes => [ 'a1', 'a2' ], provider => VO::Provider->new(TEST_PROVIDER_EXE,{}) });
ok(ref( $model->search ) eq 'ARRAY',"Model search method returns array ref.");
#ok($model->get("a1") eq "","Model get method works.");
ok(join(",",@{ $model->attributes() }) eq "a1,a2","Model attribute retrieval works.");
ok(ref($model->provider()) eq 'VO::Provider',"Model has registered provider.");
