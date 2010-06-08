package VO::Config;

use warnings;
use strict;

use base qw(Exporter);
use vars qw( @EXPORT_OK %EXPORT_TAGS );

# Context exported as global variable using :context tag:
%EXPORT_TAGS = ( 'config' => [ qw(
HEAVENS_VERSION
HEAVENS_BASE
HEAVENS_CONFIG_DIR
HEAVENS_ARCHIVE_DIR
HEAVENS_SERVICE_CONFIG_FILE
VO_TEMPLATE_DIR
VO_PROVIDER_WCS_EXE
VO_PROVIDER_WCS_PFILES_PATH)
] );

@EXPORT_OK = ( @{ $EXPORT_TAGS{'config'} } );

use constant HEAVENS_VERSION     => '@@HEAVENS_VERSION@@';
use constant HEAVENS_BASE        => '/Users/Shared/projects/isdcvo';
use constant HEAVENS_CONFIG_DIR  => HEAVENS_BASE.'/config';
use constant HEAVENS_ARCHIVE_DIR => HEAVENS_BASE.'/rep/arc/rev_3';
use constant HEAVENS_SERVICE_CONFIG_FILE => HEAVENS_BASE.'/service.yml';

use constant VO_TEMPLATE_DIR     => HEAVENS_BASE.'/templates/tt2';
use constant VO_PROVIDER_WCS_EXE => HEAVENS_BASE.'/dist/bin/wcs_pixel_params';
use constant VO_PROVIDER_WCS_PFILES_PATH => HEAVENS_BASE.'/dist/pfiles';

1;
