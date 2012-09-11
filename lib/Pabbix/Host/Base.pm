package Pabbix::Host::Base;

use strict;
use warnings;
use Moo;

sub _add_missing_params
{
    my $self = shift;
    if( $self->filter )
    {
        $self->_add_filter;
    }
    else
    {
        $self->_add_host;
        $self->_add_ip;
        $self->_add_port;
        $self->_add_use_ip;
        $self->_add_groups;
    }
}

sub _add_host
{
    my $self = shift;
    my $json = $self->json;
    if( $self->host )
    {
        $json->{'params'}{'host'} = $self->host;
    }
    $self->json( $json );
}

sub _add_ip
{
    my $self = shift;
    my $json = $self->json;
    if( $self->ip )
    {
        $json->{'params'}{'ip'} = $self->ip;
    }
    $self->json( $json );
}

sub _add_port
{
    my $self = shift;
    my $json = $self->json;
    if( $self->port )
    {
        $json->{'params'}{'port'} = $self->port;
    }
    else
    {
        $json->{'params'}{'port'} = '10050';
    }
    $self->json( $json );
}

sub _add_use_ip
{
    my $self = shift;
    my $json = $self->json;
    if( $self->useip )
    {
        $json->{'params'}{'useip'} = 1;
    }
    else
    {
        $json->{'params'}{'useip'} = 0;
    }
    $self->json( $json );
}

sub _add_groups
{
    my $self = shift;
    my $json = $self->json;
    if( $self->groups )
    {
        $json->{'params'}{'groups'} = $self->groups;
    }
    else
    {
        $json->{'params'}{'groups'}[0]{"groupid"} = 1;
    }
    $self->json( $json );
}

sub _add_filter
{
    my $self = shift;
    my $json = $self->json;
    if( $self->hostid )
    {
        $json->{'params'}{'output'} = 'extend';
        $json->{'params'}{'hostids'}[0] = $self->hostid;
    }
    $self->json( $json );
}

has json      => ( is => 'rw' );
has url       => ( is => 'ro', required => 1 );
has authToken => ( is => 'ro', required => 1 );
has host      => ( is => 'ro' );
has ip        => ( is => 'ro' );
has port      => ( is => 'ro' );
has useip     => ( is => 'ro' );
has groups    => ( is => 'ro' );
has hostid    => ( is => 'ro' );
has filter    => ( is => 'rw' );

1;
