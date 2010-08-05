use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'VO::Service::Cutout',
    AUTHOR              => 'Shaun ASHBY <shuan.ashby@unige.ch>',
    VERSION_FROM        => 'lib/VO/Service/Cutout.pm',
    ABSTRACT_FROM       => 'lib/VO/Service/Cutout.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
	'IPC::Cmd' => 0,
	'YAML::Syck' => 0,
	'Pixel::WCS' => 0
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Heavens-VO-*' },
);
