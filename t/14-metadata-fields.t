#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'VO::Table::API::Metadata' );
}


# my $fields = [
#     { name => "Title", datatype => "char", arraysize => "*", ucd => "VOX:Image_Title", description => "Image title" },
#     { name => "URL", datatype => "char", arraysize => "*", ucd => "VOX:Image_AccessReference", description => "Image access URL" },
#     { name => "Format", datatype => "char", arraysize => "*", ucd => "VOX:Image_Format", description => "MIME type of the image" },
#     { name => "POSRA", datatype => "double", unit => "deg", ucd => "POS_EQ_RA_MAIN", description => "Image center Right Ascension" },
#     { name => "POSDEC", datatype => "double", unit => "deg", ucd => "POS_EQ_DEC_MAIN", description => "Image center Declination" },
#     { name => "Naxes", datatype => "int", ucd => "VOX:Image_Naxes", description => "Number of image axes" },
#     { name => "Naxis", datatype => "int", arraysize => "*", ucd => "VOX:Image_Naxis", description => "Length of image axis" },
#     { name => "Scale", datatype => "double", arraysize => "*", ucd => "VOX:Image_Scale", description => "Scale of image axis" },
#     { name => "SF_RefPixel", datatype => "double", arraysize => "*", ucd => "VOX:WCS_CoordRefPixel", description => "Image reference pixel" },
#     { name => "SF_RefValue", datatype => "double", arraysize => "*", ucd => "VOX:WCS_CoordRefValue", description => "Image reference value" },
#     { name => "CDMatrix", datatype => "double", arraysize => "*", ucd => "VOX:WCS_CDMatrix",description => "Image CD matrix" },
#     { name => "Instrument", datatype => "char", arraysize => "*", ucd => "INST_ID", description => "Instrument name" },
#     { name => "FileSize", datatype => "long", unit => "bytes", ucd => "VOX:Image_FileSize", description => "Image file size" },
#     { name => "SpaceFrame", datatype => "char", arraysize => "*", ucd => "VOX:STC_CoordRefFrame", description => "Image reference frame" },
#     { name => "Equinox", datatype => "double", ucd => "VOX:STC_CoordEquinox", description => "Image equinox" },
#     { name => "Projection", datatype => "char", arraysize => "3", ucd => "VOX:WCS_CoordProjection", description => "Image projection" },
#     { name => "Bandpass", datatype => "char", arraysize => "*", ucd => "VOX:BandPass_ID", description => "Bandpass name" },
#     { name => "BP_Unit", datatype => "char", arraysize => "*", ucd => "VOX:BandPass_Unit", description => "Bandpass unit" },
#     { name => "BP_RefValue", datatype => "double", ucd => "VOX:BandPass_RefValue", description => "Bandpass reference value" },
#     { name => "BP_LoLimit", datatype => "double", ucd => "VOX:BandPass_LoLimit", description => "Bandpass lower limit" },
#     { name => "BP_HiLimit", datatype => "double", ucd => "VOX:BandPass_HiLimit", description => "Bandpass upper limit" }
#     ];

# # CHeck that field objects can be created:
# map { VO::Metadata->new($_) } @$fields;
