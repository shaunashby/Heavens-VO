package VO::Table;

use warnings;
use strict;

use Carp qw(croak);

our $VERSION = '0.01';

use Template;

use VO::Config qw(:config);
use VO::QueryStatus;

use overload q{""} => \&render;

sub new() {
    my $proto = shift;
    my $class = ref($proto) || $proto;
    my $self = (@_ == 0) ? # Error if no params given
	croak("No params given.\n")
	: (ref($_[0]) eq 'HASH') ? shift
	: croak("Needs a parameter hash ref");
    
    # Data which will be passed to the template engine:
    $self->{vodata} = {
	query_status => VO::QueryStatus::OK, # Default query status is OK:
	context   => $self->{context} || croak ("VO::Table: no context given as arg."),
    };

    bless($self,$class);
    
    # Template config:
    $self->{tt} = Template->new( {
	INCLUDE_PATH => $ENV{VO_TEMPLATE_DIR} || VO_TEMPLATE_DIR,
     }) || die Template->error(),"\n";

    return $self;
}

sub query_status() {
    my $self = shift;
    @_ ? $self->{vodata}->{query_status} = shift
	: $self->{vodata}->{query_status};
}

sub error() { return sprintf("VO::Table::process: %s\n",shift->{tt}->error()); }

sub render() {
    my $self = shift;
    my $content = '';
    
    # Check for a template:
    if (exists($self->{template})) {
	$self->{tt}->process($self->{template}, $self->{vodata},\$content);
    } else {
	$self->{tt}->process(\*DATA, $self->{vodata},\$content);
    }
    return $content;
}

sub process() {
    my $self = shift;
    my $content = (ref($_[0]) eq 'SCALAR') ? shift : croak("process method takes ref to output variable.");
    $self->{tt}->process(\*DATA, $self->{vodata},$content);
}

1;

__DATA__
<VOTABLE xmlns="http://www.ivoa.net/xml/VOTable/v1.1" version="1.1">
  <RESOURCE type="results">
    <INFO name="QUERY_STATUS" value="[% query_status %]"/>
    <TABLE nrows="[% context.resultset.nrows %]">
      <FIELD name="Title" datatype="char" arraysize="*" ucd="VOX:Image_Title">
        <DESCRIPTION>Image title</DESCRIPTION>
      </FIELD>
      <FIELD name="URL" datatype="char" arraysize="*" ucd="VOX:Image_AccessReference">
        <DESCRIPTION>Image access URL</DESCRIPTION>
      </FIELD>
      <FIELD name="Format" datatype="char" arraysize="*" ucd="VOX:Image_Format">
        <DESCRIPTION>MIME type of the image</DESCRIPTION>
      </FIELD>
      <FIELD name="POSRA" datatype="double" unit="deg" ucd="POS_EQ_RA_MAIN">
        <DESCRIPTION>Image center Right Ascension</DESCRIPTION>
      </FIELD>
      <FIELD name="POSDEC" datatype="double" unit="deg" ucd="POS_EQ_DEC_MAIN">
        <DESCRIPTION>Image center Declination</DESCRIPTION>
      </FIELD>
      <FIELD name="Naxes" datatype="int" ucd="VOX:Image_Naxes">
        <DESCRIPTION>Number of image axes</DESCRIPTION>
      </FIELD>
      <FIELD name="Naxis" datatype="int" arraysize="*" ucd="VOX:Image_Naxis">
        <DESCRIPTION>Length of image axis</DESCRIPTION>
      </FIELD>
      <FIELD name="Scale" datatype="double" arraysize="*" ucd="VOX:Image_Scale">
        <DESCRIPTION>Scale of image axis</DESCRIPTION>
      </FIELD>
      <FIELD name="SF_RefPixel" datatype="double" arraysize="*" ucd="VOX:WCS_CoordRefPixel">
        <DESCRIPTION>Image reference pixel</DESCRIPTION>
      </FIELD>
      <FIELD name="SF_RefValue" datatype="double" arraysize="*" ucd="VOX:WCS_CoordRefValue">
        <DESCRIPTION>Image reference value</DESCRIPTION>
      </FIELD>
      <FIELD name="CDMatrix" datatype="double" arraysize="*" ucd="VOX:WCS_CDMatrix">
        <DESCRIPTION>Image CD matrix</DESCRIPTION>
      </FIELD>
      <FIELD name="Instrument" datatype="char" arraysize="*" ucd="INST_ID">
        <DESCRIPTION>Instrument name</DESCRIPTION>
      </FIELD>
      <FIELD name="FileSize" datatype="long" unit="bytes" ucd="VOX:Image_FileSize">
        <DESCRIPTION>Image file size</DESCRIPTION>
      </FIELD>
      <FIELD name="SpaceFrame" datatype="char" arraysize="*" ucd="VOX:STC_CoordRefFrame">
        <DESCRIPTION>Image reference frame</DESCRIPTION>
      </FIELD>
      <FIELD name="Equinox" datatype="double" ucd="VOX:STC_CoordEquinox">
        <DESCRIPTION>Image equinox</DESCRIPTION>
      </FIELD>
      <FIELD name="Projection" datatype="char" arraysize="3" ucd="VOX:WCS_CoordProjection">
        <DESCRIPTION>Image projection</DESCRIPTION>
      </FIELD>
      <FIELD name="Bandpass" datatype="char" arraysize="*" ucd="VOX:BandPass_ID">
        <DESCRIPTION>Bandpass name</DESCRIPTION>
      </FIELD>
      <FIELD name="BP_Unit" datatype="char" arraysize="*" ucd="VOX:BandPass_Unit">
        <DESCRIPTION>Bandpass unit</DESCRIPTION>
      </FIELD>
      <FIELD name="BP_RefValue" datatype="double" ucd="VOX:BandPass_RefValue">
        <DESCRIPTION>Bandpass reference value</DESCRIPTION>
      </FIELD>
      <FIELD name="BP_LoLimit" datatype="double" ucd="VOX:BandPass_LoLimit">
        <DESCRIPTION>Bandpass lower limit</DESCRIPTION>
      </FIELD>
      <FIELD name="BP_HiLimit" datatype="double" ucd="VOX:BandPass_HiLimit">
        <DESCRIPTION>Bandpass upper limit</DESCRIPTION>
      </FIELD>
      <DATA>
        <TABLEDATA>
        [% FOREACH img IN context.resultset.rows -%]
          [% INCLUDE voimgresult.tpl %]
        [% END -%]
        </TABLEDATA>
      </DATA>
    </TABLE>
  </RESOURCE>
</VOTABLE>
