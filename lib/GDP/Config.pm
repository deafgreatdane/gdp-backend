#!/usr/bin/perl

package GDP::Config;

use strict;
use warnings;

use GDP::PropertyFile;

BEGIN {
    use Exporter();
    our(@EXPORT,@ISA);
    @ISA = qw(Crawler::PropertyFile);
    @EXPORT = qw(&Get);


}

my( $config) = undef;


sub Get {
    my $package = shift;
    my $var = shift;
    Load();
    return $config->{$var};
}

sub Load {
    if ( ! $config ) {
	$config = {};
	open(IN, "<", "/GDP/configuration.txt") || die "could not open /GDP/configuration.txt\n";
	my($line);
	while($line = <IN> ) {
	    chop($line);
	    next if $line =~ m:^#:;
	    next if ! $line;

	    my ($key,$value) = split(/:/,$line);
	    $key =~ s/^\s+//;
	    $key =~ s/\s+$//;
	    $value =~ s/^\s+//;
	    $value =~ s/\s+$//;
	    $config->{$key} = $value;
	}
    }
}
1;
