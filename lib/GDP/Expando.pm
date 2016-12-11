#!/usr/bin/perl

package GDP::Expando;
our($debug);

sub parseFunction {
    my ( $source ) = @_;
    my ($func,@args);
    my ($startPos,$endPos) ;
    $startPos = index($source,"(");
    if ( $startPos <= 0 ) {
	return ($source);
    }
    $func = substr($source,0,$startPos);
    $endPos = indexBalanced($source,"(",")",$startPos+1);
    print "GDP::parseFunction($source) at $startPos,$endPos\n" if $debug > 2;
    return ($func,parseList( substr($source,$startPos + 1, $endPos - $startPos - 1)));
}
sub parseList {
    my ( $source ) = @_;
    my (@retval);
    # this needs a lot of work, to truly parse a list
    my (@rough) = split(/,/,$source);
    my $arg;
    foreach $arg(@rough) {
	push(@retval,trim($arg));
    }
    push( @retval,$source);
    return @retval;
}

sub indexBalanced {
    my ($string, $startToken, $endToken,$position) = @_;
    print "GDP::Expando::parseUntil($string,$startToken,$endToken,$position)\n" if $debug > 3;
    my $retval ="";
    my ($startPos, $endPos);
    $startPos = index($string,$startToken,$position);
    $endPos = index($string,$endToken,$position);
	print "GDP::Expando::indexBalanced($string) found at $startPos - $endPos\n" if $debug > 3;
    if ($startPos < $endPos && $startPos >= 0 ) {
	# we found a ( before the ) 
	# check to see if it's escaped
	if ( isEscaped( $startToken, $string)) {
	    return indexBalanced($string,$startToken,$endToken, $startPos + 1);
	} else {
	    my ($innerPos) = indexBalanced($string,$startToken,$endToken,$startPos +1);
	    return indexBalanced($string,$startToken,$endToken,$innerPos +1);
	}
    } else {
	print "GDP::Expando::indexBalanced($string) found at $endPos\n" if $debug > 4;
	return $endPos;
    }
}

sub isEscaped {
    my ($token, $string) = @_;
    my ($position) = index($string,$token);
    if ( $position < 1 ) {
	return 0;
    }
    if ( substr($string,$position -1,1) eq "\\") {
	return 1;
    } else {
	return 0;
    }
}
sub trim {
    my ($string) = @_;
    $string =~ s:^\s*::;
    $string =~ s:\s*$::;
    return $string;
}
1;
