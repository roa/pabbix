package Pabbix::Trigger::Base;

use strict;
use warnings;
use Moo;

sub _add_missing_params
{
    my $self = shift;
    $self->_add_status;
    $self->_add_hostid;
    $self->_add_host;
    $self->_add_description;
    $self->_add_expression;
    $self->_add_nodeids;
}

sub _add_status
{
    my $self = shift;
    my $json = $self->json;
    if( $self->statusValue )
    {
        $json->{'params'}{'status'} = $self->statusValue;
    }
    $self->json( $json );
}

sub _add_hostid
{
    my $self = shift;
    my $json = $self->json;
    if( $self->hostid )
    {
        $json->{'params'}{'hostid'} = $self->hostid;
    }
    $self->json( $json );
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

sub _add_description
{
    my $self = shift;
    my $json = $self->json;
    if( $self->description )
    {
        $json->{'params'}{'description'} = $self->description;
    }
    $self->json( $json );
}

sub _add_expression
{
    my $self = shift;
    my $json = $self->json;
    if( $self->expression )
    {
        $json->{'params'}{'expression'} = $self->expression;
    }
    $self->json( $json );
}

sub _add_nodeids
{
    my $self = shift;
    my $json = $self->json;
    if( $self->nodeids )
    {
        $json->{'params'}{'nodeids'} = $self->nodeids;
    }
    $self->json( $json );
}

has json        => ( is => 'rw' );
has url         => ( is => 'ro', required => 1 );
has authToken   => ( is => 'ro', required => 1 );
has statusValue => ( is => 'ro' );
has host        => ( is => 'ro' );
has hostid      => ( is => 'ro' );
has description => ( is => 'ro' );
has expression  => ( is => 'ro' );
has nodeids     => ( is => 'ro' );
has _get        => ( is => 'rw' );
has _create     => ( is => 'rw' );

1;
