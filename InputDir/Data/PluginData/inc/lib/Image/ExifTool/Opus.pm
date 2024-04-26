#line 1 "Image/ExifTool/Opus.pm"
#------------------------------------------------------------------------------
# File:         Opus.pm
#
# Description:  Read Ogg Opus audio meta information
#
# Revisions:    2016/07/14 - P. Harvey Created
#
# References:   1) https://www.opus-codec.org/docs/
#               2) https://wiki.xiph.org/OggOpus
#               3) https://tools.ietf.org/pdf/rfc7845.pdf
#------------------------------------------------------------------------------

package Image::ExifTool::Opus;

use strict;
use vars qw($VERSION);

$VERSION = '1.00';

# Opus metadata types
%Image::ExifTool::Opus::Main = (
    NOTES => q{
        Information extracted from Ogg Opus files.  See
        L<https://www.opus-codec.org/docs/> for the specification.
    },
    'OpusHead' => {
        Name => 'Header',
        SubDirectory => { TagTable => 'Image::ExifTool::Opus::Header' },
    },
    'OpusTags' => {
        Name => 'Comments',
        SubDirectory => { TagTable => 'Image::ExifTool::Vorbis::Comments' },
    },
);

%Image::ExifTool::Opus::Header = (
    PROCESS_PROC => \&Image::ExifTool::ProcessBinaryData,
    GROUPS => { 2 => 'Audio' },
    0 => 'OpusVersion',
    1 => 'AudioChannels',
  # 2 => 'PreSkip' (int16u)
    4 => {
        Name => 'SampleRate',
        Format => 'int32u',
    },
    8 => {
        Name => 'OutputGain',
        Format => 'int16u',
        ValueConv => '10 ** ($val/5120)',
    },
);

1;  # end

__END__

#line 98

