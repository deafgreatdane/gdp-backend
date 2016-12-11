#!/usr/bin/perl
package GDP::PropertyFile;
use strict;
use warnings;

BEGIN {
    use Exporter();
    our(@EXPORT);
    @EXPORT = qw(&newPropertyFile);
}

sub New {
    my $package = shift;
    my $retval = {};
    $retval->{'pairs'} = {};
    bless $retval,$package;
    return $retval;
}

sub Load {
    my $package = shift;
    my $fileName = shift;
    if ( ! -e $fileName ) {
	print STDERR "Load error: $fileName does not exist.\n";
	return;
    }
    my $retval = $package->New();
    $retval->{'fileName'} = $fileName;
    open (IN,"<$fileName") ;
    my $line ;
    while($line = <IN>) {
	chop($line);
	my ($var,$val) = split(/:/,$line,2);
	next if ! $var;
	next if ! $val;
	$var =~ s/^\s+//;
	$var =~ s/\s+$//;
	$val =~ s/^\s+//;
	$val =~ s/\s+$//;
	$retval->setProperty($var,$val);
    }
    return $retval;
}

sub toString {
    my $self = shift;
    my $prefix = shift;
    if ( ! $prefix ) {
	$prefix = "";
    }
    my $var;
    my $retval = "";
    foreach $var (keys(%{$self->{'pairs'}})) {
	next if ! $self->{'pairs'}->{$var};
	$retval .= "$prefix$var: " . $self->{'pairs'}->{$var} . "\n";
    }
    return $retval;
}

sub getProperty {
    my $self = shift;
    my $var = shift;
    return $self->{'pairs'}->{$var};
}
sub setProperty {
    my $self = shift;
    my $var = shift;
    my $val = shift;
    $self->{'pairs'}->{$var} = $val;
}

##### file routines
sub getFileName {
    my $self = shift;
    return $self->{'fileName'};
}
sub save {
    my $self = shift;
    my $fileName = shift;
    if ( $fileName && $self->{'fileName'} ) {
	print STDERR "$fileName not saved, object already has a fileName property\n";
	return -1;
    } elsif ( ! $fileName ) {
	$fileName = $self->{'fileName'};
    }
    open(OUT,">$fileName");
    print OUT $self->toString();
    close(OUT);
    return 0;
}

1;
