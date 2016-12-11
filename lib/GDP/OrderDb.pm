package GDP::OrderDb;

use DBI;
use GDP::Config;

use strict;
our ($debug) = 0;

sub getDatabaseHandle {
    my $dsn = 'DBI:mysql:' . GDP::Config->Get('database.schema') . ":" . GDP::Config->Get('server.name');
    my $dbuser = GDP::Config->Get('database.user');
    my $dbpassword = GDP::Config->Get('database.password');
    my $dbh = DBI->connect($dsn,$dbuser,$dbpassword);
    return $dbh;
}

sub getEventInfo {
    my ( $dbh ) = shift;
    my ( $eventCode ) = shift;
    my $sth = $dbh->prepare(qq{select event_id,catalog_code,event_name,pp_price_model,directory_style from event where event_tid = '$eventCode'});
    $sth->execute();
    my @row = $sth->fetchrow_array();
    my $retval = {};
    $retval->{'eventId'} = $row[0];
    $retval->{'code'} = $eventCode;
    $retval->{'catalogCode'} = $row[1];
    $retval->{'description'} = $row[2];
    $retval->{'priceModel'} = $row[3];
    $retval->{'directoryStyle'} = $row[4];
    return $retval;
}

1;
