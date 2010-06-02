#!perl -T

use Test::More tests => 6;

use VO::Context;
my $context = VO::Context->new;

ok(ref($context) eq 'VO::Context',"Context instantiation.");
ok(ref($context->stash) eq 'HASH',"Context stash is a hash ref.");

$context->stash->{testing} = "This is a test";
ok($context->stash->{testing} eq "This is a test","Context stash method.");

can_ok($context,'errors');
ok(ref($context->errors) eq 'ARRAY',"Context errors is a array ref.");

push(@{ $context->errors },"error no. 1");
push(@{ $context->errors },"error no. 2");

ok($#{$context->errors} == 1,"Context errors method.");
