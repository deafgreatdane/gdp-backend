#!/usr/bin/perl

package GDP::TabDb;
use GDP::Text;
use strict;
no strict 'refs';

our($debug) = 0;

sub readFile {
    my ($fileName) = shift;
    my ($rowDefinition) = shift;
    if (! open(IN,"<$fileName") ) {
	print STDERR "GDP::TabDb::readFile $fileName not found\n" ;
	return "";
    }
    my ($retval) = [];
    if ( ! $rowDefinition ) {
	# grab it from the first line
	my ($firstRow);
	$firstRow = <IN>;
	print STDERR "GDP::TabDb::readFile getting definitions from $firstRow\n" if $debug > 5;
	chomp($firstRow);
	$rowDefinition = [split(/\t/,$firstRow,-1)];
    }
    my(@columns);
    while (<IN>) {

	chomp;
	if ( ! $_ ) {
	    next;
	}
	print STDERR "GDP::TabDb::readFile: line $_ ==\n" if $debug > 5;
	@columns = split(/\t/,$_,-1);
	print STDERR "GDP::TabDb::readFile: found " . scalar(@columns) . " columns\n" if $debug > 4;
	push(@$retval,convertArrayToHash($rowDefinition,\@columns));
    }
    return $retval;

}
sub makeIndex {
    my($file) = shift;
    my ($column) = shift;
    my($retval) = {};
    my($row);
    foreach $row (@{$file}) {
	print STDERR "GDP::TabDb::makeIndex '$column' on '" . $row->{$column} . "'\n" if $debug > 5;
	$retval->{  $row->{$column}} = $row;
    }
    return $retval;
}
sub convertArrayToHash {
    my($rowDefinition) = shift;
    my($rowArray) = shift;
    if ( scalar(@{$rowDefinition}) < scalar(@{$rowArray})) {
	print STDERR "GDP::TabDb::convertArrayToHash size of rowDefinition(" . scalar(@$rowDefinition) . ") and rowArray(" . scalar(@$rowArray) . ") doesn't have enough columns\n" if $debug > 0 ;
	return {};
    }
    my($i);
    my ($retval) = {};
    for ( $i = 0 ; $i < scalar(@{$rowArray}) ; $i++ ) {
	print STDERR "GDP::TabDb::convertArrayToHash $i (" . $rowDefinition->[$i] . "): " . $rowArray->[$i] . "\n" if $debug > 4;
	$retval->{$rowDefinition->[ $i]} = $rowArray->[$i];
    }
    return $retval;
}
1;
