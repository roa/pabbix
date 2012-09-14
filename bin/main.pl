#!/usr/bin/perl

use strict;
use warnings;
use lib '/home/roa/programming/pabbix/lib/';

use Pabbix;
use Array::Diff;
use Getopt::Long;

sub uniqArray
{
    my %all;
    grep { $all { $_ } = 0 } @_;
    return ( keys %all );
}

my $user;
my $passwd;
my $url;
my $file;
my $ok = 1;
my @after;
my @before;
my $fh;

GetOptions(
    "user|u=s"   => \$user,
    "passwd|p=s" => \$passwd,
    "url=s"      => \$url,
    "file|f=s"   => \$file
);

$ok = defined( $user );  
$ok = defined( $passwd );
$ok = defined( $url );
$ok = defined( $file );

unless( $ok )
{
    die "blah\n";
}

my $authToken = Pabbix::Auth->new(
    url => $url,
    user => $user,
    passwd => $passwd,
)->get();

my $response =  Pabbix::Trigger::Get->new(
    authToken => $authToken,
    url => $url,
    statusValue => 'PROBLEM',
)->get;

use Data::Dumper;
print Dumper $response;

if( -f $file )
{
    open( $fh, '<', $file );
    @before = <$fh>;
    close $fh;
}

foreach( @{$response->{'result'}} )
{
    my $host = $_->{'host'};
    my $desc = $_->{'description'};
    if( $desc =~ /{HOSTNAME}/ )
    {
        $desc =~ s/{HOSTNAME}/$host/;
        push( @after, $desc . "\n" );
    }
    else
    {
        push( @after, $desc . " " .  $host . "\n"  );
    }
}

@before = sort( uniqArray( @before ) );
@after  = sort( uniqArray( @after ) );
my $diff = Array::Diff->diff( \@before, \@after );
my $add_ref = $diff->added;
my $del_ref = $diff->deleted;

if( @$add_ref )
{
    print "new problems:\n";
    for( @$add_ref )
    {
        print "$_";
    }
}
if( @$del_ref )
{
    print "solved problems:\n";
    for( @$del_ref )
    {
        print "$_";
    }
}

open( $fh, '>', $file );
for( @after )
{
    print $fh $_;
}
