#____________________________________________________________________ 
# File: Config.pm
#____________________________________________________________________ 
#  
# Author: Shaun ASHBY <Shaun.Ashby@gmail.com>
# Update: 2010-05-12 15:16:26+0200
# Revision: $Id$ 
#
# Copyright: 2010 (C) Shaun ASHBY
#
#--------------------------------------------------------------------
package Heavens::Config;

use strict;
use warnings;

use base qw(Exporter);

# Globals:
use vars qw( @EXPORT_OK %EXPORT_TAGS $context );

# Context exported as global variable using :context tag:
%EXPORT_TAGS = ( 'context' => [ qw( $context ) ], 'config' => [ qw( HEAVENS_VERSION HEAVENS_BASE HEAVENS_CONFIG_DIR ) ] );
@EXPORT_OK = ( @{ $EXPORT_TAGS{'context'} },@{ $EXPORT_TAGS{'config'} } );

# Context version:
use constant HEAVENS_VERSION => '@@HEAVENS_VERSION@@';

# Set configuration parameters here:
use constant HEAVENS_BASE        => '@@HEAVENS_BASE@@';
use constant HEAVENS_CONFIG_DIR  => HEAVENS_BASE.'/config';

# Create context object:
$context = bless { } => __PACKAGE__;

# Methods to access configuration parameters:
sub base() { HEAVENS_BASE };

sub config() { HEAVENS_CONFIG_DIR };

sub version() { HEAVENS_VERSION };

1;
