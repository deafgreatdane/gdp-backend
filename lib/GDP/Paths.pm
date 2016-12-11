package GDP::Paths;

use strict;
our ($debug) = 0;

sub getAbsolute {
    my ($relativeTo, $dest) = @_;
    print "GDP::Paths::getAbsolute($relativeTo,$dest) \n" if $debug > 3 ;
    if ( ! isAbsolute($relativeTo)) {
	print "GDP::Paths::getAbsolute($relativeTo,$dest): first arg must be absolute\n" if $debug > 0 ;
	return $dest;
    }
    # quick exit if we're already absolute
    return $dest if isAbsolute($dest);
    # quick exit if it's a more complete url
    return $dest if $dest =~ /^http/;
    return $dest if $dest =~ /^mailto/;
    return $dest if $dest =~ /^#/;

    # maybe it's explicitly local, chop off any "./"
    $dest =~ s:^\./::;

    # it's relative to the current directory
    if ( $dest !~ m:^\.\./: ) {
	return getDirectoryOf($relativeTo) . $dest;
    }

    # recurse up
    $dest =~ s:^\.\./::;
    $relativeTo = getParentDirectoryOf( getDirectoryOf($relativeTo) );
    print "GDP::Paths::getAbsolute($relativeTo,$dest) recursing\n" if $debug > 3;
    return getAbsolute( $relativeTo,$dest );
}
sub getRelative {
    my ( $from, $to) = @_;

    print STDOUT "getRelative( $from , $to)\n" if $debug > 3 ;
    if ( ! isAbsolute($from) || ! isAbsolute($to)) {
	print "GDP::Paths::getRelative($from,$to): both args must be absolute\n" if $debug > 0 ;
	return $to;
    }

    # making $from a directory will simplify things
    $from = getDirectoryOf($from);

    # if we point down, things get simple:
    # this also catches the case when $from eq "/"
    if ( $to =~ s:^$from:: ) {
	return $to;
    }

    # check the first chunk of each path
    my ( $first1, $first2 ) ;
    $from =~ m:^(/[^/]*): ;
    $first1 = $1;
    $to =~ m:^(/[^/]*): ;
    $first2 = $1;

    # if the chunks match, dig a bit deeper
    if ( $first1 eq $first2 ) {
	print "GDP::Paths::getRelative(): recursing\n" if $debug > 3;
	$from =~ s:$first1::;
	$to =~ s:$first2::;
	return getRelative($from,$to);
    }

    # we're at the branching point of the two directories
    $to =~ s:/::;
    return getDots(getDepth($from)) . $to;
}
sub getDotDot {
    my $dir = shift;
    return getDots( getDepth($dir)  ); 
}
sub getDots {
    my ( $depth)  = @_;
    my $retval = "";
    my $i;
    for ( $i = 0 ; $i <  $depth ; $i++) {
	$retval .= "../";
    }
    return $retval;

}
sub getDepth {
    my $dir = shift;

    my @slashes = ( $dir =~ m:/:g);
    my $retval = scalar(@slashes) ;
    if ( $dir =~ m:^/:) {
	$retval--;
    }
    #print STDOUT "depth of $dir is $retval\n"; 	
    return $retval;
}

# not necessarily the parent, eg /foo/ returns /foo/
# use getParentDirectoryOf instead if you want guaranteed parent
sub getDirectoryOf {
    my ($arg) = @_;
    $arg =~ s:[^/]*$::;
    return $arg;
}


sub isDirectory {
    my ($arg) = @_;
    return $arg =~ m:/$:;
}
sub isAbsolute {
    my ($arg) = @_;
    return $arg =~ m:^/:;
}
sub getParentDirectoryOf {
    my ($arg) = @_;
    if ( isDirectory( $arg ) ) {
	# chop the last slash, so it doesn't look like one
	$arg =~ s:/$::;
    }
    return getDirectoryOf($arg);
}

1;
