use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Heavens::VO',
    AUTHOR              => 'Shaun ASHBY <Shaun.Ashby@unige.ch>',
    VERSION_FROM        => 'lib/Heavens/VO.pm',
    ABSTRACT_FROM       => 'lib/Heavens/VO.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Heavens-VO-*' },
);
