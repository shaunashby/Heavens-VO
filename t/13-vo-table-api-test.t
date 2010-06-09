#!perl -T

use Test::More tests => 26;

BEGIN {
    use_ok( 'VO::Table::API::VOTABLE' );
}

use XML::Parser;
use Data::Dumper;
use File::Basename;

my $toplevelclass="VO::Table::API";
my $dir = dirname($0);
my $inputfile="$dir/xml/test-votable.xml";

# Read the file:
open (IN, "< $inputfile") or die "Cannot read file $inputfile: $!\n";
my $string = join("", <IN>);
close (IN);
# Strip spaces at the beginning and end of the line:
$string =~ s/^\s+//g;
$string =~ s/\s+$//g;
# Finally strip the newlines:
$string =~ s/\n//g;
# Strip out spaces in between tags:
$string =~ s/>\s+</></g;
# Parse the catalogue and remove top-level white space
my $xml = (new XML::Parser (Style => "Objects",
			    ErrorContext => 3,
			    Pkg   => $toplevelclass))->parse($string);

# Get the top-level object:
my $object = $xml->[0];

ok(ref($object) eq 'VO::Table::API::VOTABLE', "XML file parse returned VO::Table::API::VOTABLE object.");
ok($object->xmlns eq 'http://www.ivoa.net/xml/VOTable/v1.1',"VOTable has correct namespace.");
ok($object->version eq '1.1', "VOTable has correct version.");

# Look at RESOURCE:
my $resource = $object->resources->[0];
ok(ref($resource) eq 'VO::Table::API::RESOURCE',"VOTable contains a RESOURCE block.");
ok($resource->type eq 'results',"VOTable RESOURCE block has type \"results\".");

my $info = $resource->info;
ok(ref($info) eq 'VO::Table::API::INFO',"VOTable RESOURCE block contains INFO element.");
ok($info->name eq 'QUERY_STATUS',"VOTable INFO block has name \"QUERY_STATUS\".");
ok($info->value eq 'OK',"VOTable INFO block has value \"OK\".");

my $table = $resource->table;
ok(ref($table) eq 'VO::Table::API::TABLE',"VOTable RESOURCE block has table element.");
ok($table->nrows == 1,"VOTable TABLE element has 1 row.");

my $fields = $table->fields;
ok(ref($fields->[0]) eq 'VO::Table::API::FIELD',"VOTable TABLE element has FIELD entry.");
ok(scalar(@$fields) == 3,"VOTable TABLE element has 3 FIELD entries in total.");

my $title_field = $fields->[0];
ok($title_field->name eq 'Title',"VOTable TABLE has Title field.");
ok($title_field->datatype eq 'char',"VOTable Title field has type \"char\".");
ok($title_field->arraysize eq '*',"VOTable Title field has arraysize \"*\".");
ok($title_field->ucd eq 'VOX:Image_Title',"VOTable Title field has ucd \"VOX:Image_Title\".");
ok($title_field->description eq 'Image title',"VOTable Title field has description \"Image title\".");

my $data = $table->data;
ok(ref($data) eq 'VO::Table::API::DATA',"VOTable TABLE has DATA block.");

my $tabledata = $data->tabledata;
ok(ref($tabledata) eq 'VO::Table::API::TABLEDATA',"VOTable DATA block has TABLEDATA element.");
ok(scalar(@{$tabledata->rows}) == 1,"VOTable TABLEDATA element has 1 row.");

my $table_row = $tabledata->rows->[0];
ok(ref($table_row) eq 'VO::Table::API::TR',"VOTable TABLEDATA element has row element TR.");
ok(scalar(@{$table_row->cells}) == 3,"VOTable TABLEDATA row has 3 cells.");

my $row_cells = $table_row->cells;

map {
    ok(ref($_) eq 'VO::Table::API::TD' && length("$_") > 5, "VOTable TABLEDATA cell has content $_ .");
} @$row_cells;
