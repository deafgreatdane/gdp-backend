#!/usr/bin/perl
package GDP::Text;
use strict;

sub convertCsvToTabs {
    my ($line) = shift;
    my ($start) = shift;
    chomp $line;
    my ($column);
    my(@retval);
    do {
	($column,$start) = readCsvColumn($line,$start);
	push(@retval,$column);
    } while ( $start >= 0 );
    return @retval;
}

#
sub readCsvColumn {
    my ($string) = shift;
    my ($startAt ) = shift;

    my($column);
    my $nextChar;
    if ( $startAt >= length($string)) {
	$startAt = -1;
    } elsif (nextChar($string,$startAt) eq "\"" ) {
	# move past the start quote
	$startAt++;

	# parse up to the next ", moving past escaped quotes
	my ($closeQuote) = $startAt;
	my $truth = 1;
	do {
	    $closeQuote = index($string,"\"",$closeQuote);
	    #print "looking for escape in $string $closeQuote\n";
	    if ( prevChar($string,$closeQuote) ne "\\" || ! prevChar($string,$closeQuote)) {
		$truth = 0;
	    } else {
		$closeQuote++;
	    }

	} while($truth);

	# extract the column
	$column = trim(substr($string,$startAt, $closeQuote-$startAt));
	# take aout any escaped quotes
	$column =~ s:\\":":g;

	# set the new startAt;
	$startAt = $closeQuote +1;
	# possibly walk past the next comma
	#TODO: make it handle spaces between columns
	if ( substr($string,$startAt,1) eq ",") {
	    $startAt++;
	}
    } else {
	print STDERR "confused about ". nextChar($string,$startAt) . " using $string\n";
	$startAt = -1;
    }
    return ($column,$startAt);
}
sub nextChar {
    my ($string) = shift;
    my ($startAt) = shift;
    return substr($string,$startAt,1);
}
sub prevChar {
    my ($string) = shift;
    my ($startAt) = shift;
    if ( $startAt <= 0 ) {
	return "";
    } else {
	return substr($string,$startAt -1,1);
    }

}
sub trim {
    my($string) = shift;
    $string =~ s:^\s*::;
    $string =~ s:\s*$::;
    return $string;
}
1;
