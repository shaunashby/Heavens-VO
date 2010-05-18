#____________________________________________________________________ 
# File: VO.pm
#____________________________________________________________________ 
#  
# Author: Shaun ASHBY <Shaun.Ashby@gmail.com>
# Update: 2010-05-17 16:56:30+0200
# Revision: $Id$ 
#
# Copyright: 2010 (C) Shaun ASHBY
#
#--------------------------------------------------------------------
package VO::VOTABLE;
#
# text/xml; content-type: x-votable
#
# <VOTABLE xmlns="http://www.ivoa.net/xml/VOTable/v1.1" version="1.1">
#   <RESOURCE type="results">
#     <INFO name="QUERY_STATUS" value="OK"/>
#     <TABLE nrows="1">
#       <FIELD name="Title" datatype="char" arraysize="*" ucd="VOX:Image_Title">
#         <DESCRIPTION>Image title</DESCRIPTION>
#       </FIELD>
#       <FIELD name="URL" datatype="char" arraysize="*" ucd="VOX:Image_AccessReference">
#         <DESCRIPTION>Image access URL</DESCRIPTION>
#       </FIELD>
#       <FIELD name="Format" datatype="char" arraysize="*" ucd="VOX:Image_Format">
#         <DESCRIPTION>MIME type of the image</DESCRIPTION>
#       </FIELD>
#       <DATA>
#         <TABLEDATA>
#           <TR>
#             <TD>___Title___</TD>
#             <TD>___URL___</TD>
#             <TD>image/fits</TD>
#           </TR>
#         </TABLEDATA>
#       </DATA>
#     </TABLE>
#   </RESOURCE>
# </VOTABLE>
#

use strict;
use warnings;

our $VERSION = '0.1';

sub xmlns() { return shift->{'xmlns'}; }
sub version() { return shift->{'version'}; }

sub resources() {
    my $resources = [];
    map {       
	if (ref($_) =~ /RESOURCE$/) {
	    push(@$resources,$_);
	}
    } @{ shift->{'Kids'} };
    return $resources;
}

package VO::RESOURCE;

sub type() { return shift->{'type'}; }

sub info() {
    map {    
	if (ref($_) =~ /INFO$/) {
	    return $_;
	}
    } @{ shift->{'Kids'} };
    return undef;
}

sub table() {
    map {    
	if (ref($_) =~ /TABLE$/) {
	    return $_;
	}
    } @{ shift->{'Kids'} };
    return undef;
}

package VO::INFO;

sub name() { return shift->{'name'}; }
sub value() { return shift->{'value'}; }

package VO::TABLE;

sub nrows() { return shift->{'nrows'}; }

sub fields() {
    my $fields = [];
    map {       
	if (ref($_) =~ /FIELD$/) {
	    push(@$fields,$_);
	}
    } @{ shift->{'Kids'} };
    return $fields;
}

sub data() {
    map {    
	if (ref($_) =~ /DATA$/) {
	    return $_;
	}
    } @{ shift->{'Kids'} };
    return undef;
}

package VO::FIELD;

sub name() { return shift->{'name'}; }
sub datatype() { return shift->{'datatype'}; }
sub arraysize() { return shift->{'arraysize'} || '*'; }
sub ucd() { return shift->{'ucd'}; }

sub description() {    
    map {       
	if (ref($_) =~ /DESCRIPTION$/) {
	    return "$_";
	}
    } @{ shift->{'Kids'} };
    return '';
}

package VO::DESCRIPTION;

use overload qw{""} => sub {
    map {       
	if (ref($_) =~ /Characters$/) {
	    return $_->{'Text'};
	}
    } @{ shift->{'Kids'} };
    return '';
};

package VO::DATA;

sub tabledata() {
    map {    
	if (ref($_) =~ /TABLEDATA$/) {
	    return $_;
	}
    } @{ shift->{'Kids'} };
    return undef;
}

package VO::TABLEDATA;

sub rows() {
    my $rows = [];
    map {
	if (ref($_) =~ /TR$/) {
	    push(@$rows,$_);
	}
    } @{ shift->{'Kids'} };
    return $rows;
}

package VO::TR;

sub cells() {
    my $cells = [];
    map {
	if (ref($_) =~ /TD$/) {
	    push(@$cells,$_);
	}
    } @{ shift->{'Kids'} };
    return $cells;
}

package VO::TD;

use overload qw{""} => sub {
    map {       
	if (ref($_) =~ /Characters$/) {
	    return $_->{'Text'};
	}
    } @{ shift->{'Kids'} };
    return '';
};
