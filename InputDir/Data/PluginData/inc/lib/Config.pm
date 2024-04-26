#line 1 "Config.pm"
# This file was created by configpm when Perl was built. Any changes
# made to this file will be lost the next time perl is built.

# for a description of the variables, please have a look at the
# Glossary file, as written in the Porting folder, or use the url:
# http://perl5.git.perl.org/perl.git/blob/HEAD:/Porting/Glossary

package Config;
use strict;
use warnings;
use vars '%Config', '$VERSION';

$VERSION = "5.024000";

# Skip @Config::EXPORT because it only contains %Config, which we special
# case below as it's not a function. @Config::EXPORT won't change in the
# lifetime of Perl 5.
my %Export_Cache = (myconfig => 1, config_sh => 1, config_vars => 1,
		    config_re => 1, compile_date => 1, local_patches => 1,
		    bincompat_options => 1, non_bincompat_options => 1,
		    header_files => 1);

@Config::EXPORT = qw(%Config);
@Config::EXPORT_OK = keys %Export_Cache;

# Need to stub all the functions to make code such as print Config::config_sh
# keep working

sub bincompat_options;
sub compile_date;
sub config_re;
sub config_sh;
sub config_vars;
sub header_files;
sub local_patches;
sub myconfig;
sub non_bincompat_options;

# Define our own import method to avoid pulling in the full Exporter:
sub import {
    shift;
    @_ = @Config::EXPORT unless @_;

    my @funcs = grep $_ ne '%Config', @_;
    my $export_Config = @funcs < @_ ? 1 : 0;

    no strict 'refs';
    my $callpkg = caller(0);
    foreach my $func (@funcs) {
	die qq{"$func" is not exported by the Config module\n}
	    unless $Export_Cache{$func};
	*{$callpkg.'::'.$func} = \&{$func};
    }

    *{"$callpkg\::Config"} = \%Config if $export_Config;
    return;
}

die "$0: Perl lib version (5.24.0) doesn't match executable '$^X' version ($])"
    unless $^V;

$^V eq 5.24.0
    or die sprintf "%s: Perl lib version (5.24.0) doesn't match executable '$^X' version (%vd)", $0, $^V;


sub FETCH {
    my($self, $key) = @_;

    # check for cached value (which may be undef so we use exists not defined)
    return exists $self->{$key} ? $self->{$key} : $self->fetch_string($key);
}

sub TIEHASH {
    bless $_[1], $_[0];
}

sub DESTROY { }

sub AUTOLOAD {
    my $config_heavy = 'Config_heavy.pl';
    if (defined &ActivePerl::_CONFIG_HEAVY) {
       $config_heavy = ActivePerl::_CONFIG_HEAVY();
    }
    require $config_heavy;
    goto \&launcher unless $Config::AUTOLOAD =~ /launcher$/;
    die "&Config::AUTOLOAD failed on $Config::AUTOLOAD";
}

sub __unused {
    # XXX Keep PerlApp happy
    require 'Config_heavy.pl';
}

# tie returns the object, so the value returned to require will be true.
tie %Config, 'Config', {
    archlibexp => 'C:\Perl\\lib',
    archname => 'MSWin32-x86-multi-thread-64int',
    d_readlink => undef,
    d_symlink => undef,
    dlext => 'dll',
    dlsrc => 'dl_win32.xs',
    dont_use_nlink => undef,
    exe_ext => '.exe',
    inc_version_list => '',
    intsize => '4',
    ldlibpthname => '',
    osname => 'MSWin32',
    osvers => '6.1',
    path_sep => ';',
    privlibexp => 'C:\Perl\\lib',
    scriptdir => 'C:\Perl\\bin',
    sitearchexp => 'C:\Perl\\site\\lib',
    sitelibexp => 'C:\Perl\\site\\lib',
    so => 'dll',
    useithreads => 'define',
    usevendorprefix => undef,
    version => '5.24.0',
};
