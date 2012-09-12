package Pabbix::Item::Base;

use strict;
use warnings;
use Moo;

extends 'Pabbix::Base';

sub _add_missing_params
{
    my $self = shift;
    if( $self->method eq 'item.get' )
    {
        $self->_add_search_pattern;
    }
    elsif( $self->method eq 'item.delete' )
    {
        $self->_add_delete_params;
    }
    elsif( $self->method eq 'item.create' )
    {
        $self->_add_description;
        $self->_add_key;
        $self->_add_hostid;
        $self->_add_application;
    }
}

sub _add_search_pattern
{
    my $self = shift;
    my $json = $self->json;
    $json->{'params'}{'output'} = 'extend';
    $json->{'params'}{'search'} = $self->search;
    $self->json( $json );
}

sub _add_delete_params
{
    my $self = shift;
    my $json = $self->json;
    $json->{'params'} = $self->itemids;
    $self->json( $json );
}

sub _add_description
{
    my $self = shift;
    if( $self->description )
    {
        my $json = $self->json;
        $json->{'params'}{'description'} = $self->description;
        $self->json( $json )
    }
    else
    {
        die 'need description';
    }
}

sub _add_key
{
    my $self = shift;
    if( $self->key_ )
    {
        my $json = $self->json;
        $json->{'params'}{'key_'} = $self->key_;
        $self->json( $json )
    }
    else
    {
        die 'need key_';
    }
}

sub _add_hostid
{
    my $self = shift;
    if( $self->hostid )
    {
        my $json = $self->json;
        $json->{'params'}{'hostid'} = $self->hostid;
        $self->json( $json )
    }
    else
    {
        die 'need hostid';
    }
}

sub _add_application
{
    my $self = shift;
    if( $self->application )
    {
        my $json = $self->json;
        $json->{'params'}{'application'} = $self->application;
        $self->json( $json )
    }
}

has url         => ( is => 'ro', required => 1 );
has authToken   => ( is => 'ro', required => 1 );
has search      => ( is => 'ro' );
has itemids     => ( is => 'ro' );
has description => ( is => 'ro' );
has key_        => ( is => 'ro' );
has hostid      => ( is => 'ro' );
has application => ( is => 'ro' );

1;
