#line 1 "Image/ExifTool/Other.pm"
#------------------------------------------------------------------------------
# File:         Other.pm
#
# Description:  Read meta information from other uncommon formats
#
# Revisions:    2021/07/16 - P. Harvey Created
#
# References:   1) PFM - http://www.pauldebevec.com/Research/HDR/PFM/
#------------------------------------------------------------------------------

package Image::ExifTool::Other;

use strict;
use vars qw($VERSION);
use Image::ExifTool qw(:DataAccess :Utils);
use Image::ExifTool::Exif;

$VERSION = '1.00';

# Other info
%Image::ExifTool::Other::PFM = (
    GROUPS => { 0 => 'File', 1 => 'File', 2 => 'Image' },
    VARS => { NO_ID => 1 },
    NOTES => q{
        Tags extracted from Portable FloatMap images. See
        L<http://www.pauldebevec.com/Research/HDR/PFM/> for the specification.
    },
    ColorSpace  => { PrintConv => { PF => 'RGB', 'Pf' => 'Monochrome'} },
    ImageWidth  => { },
    ImageHeight => { },
    ByteOrder   => { PrintConv => '$val > 0 ? "Big-endian" : "Little-endian"' },
);

#------------------------------------------------------------------------------
# Extract information from a Portable FloatMap image
# Inputs: 0) ExifTool object reference, 1) dirInfo reference
# Returns: 1 on success, 0 if this wasn't a valid PFM file
sub ProcessPFM2($$)
{
    my ($et, $dirInfo) = @_;
    my $raf = $$dirInfo{RAF};
    my $buff;
    return 0 unless $raf->Read($buff, 256) and $buff =~ /^(P[Ff])\x0a(\d+) (\d+)\x0a([-+0-9.]+)\x0a/;
    $et->SetFileType('PFM', 'image/x-pfm');
    my $tagTablePtr = GetTagTable('Image::ExifTool::Other::PFM');
    $et->HandleTag($tagTablePtr, ColorSpace => $1);
    $et->HandleTag($tagTablePtr, ImageWidth => $2);
    $et->HandleTag($tagTablePtr, ImageHeight => $3);
    $et->HandleTag($tagTablePtr, ByteOrder => $4);
    # hack to set proper file description (extension is the same for Printer Font Metrics files)
    $Image::ExifTool::static_vars{OverrideFileDescription}{PFM} = 'Portable FloatMap',
    return 1;
}

1;  # end

__END__

#line 93

