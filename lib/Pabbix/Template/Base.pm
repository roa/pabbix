package Pabbix::Template::Base;

use strict;
use warnings;
use Moo;

extends 'Pabbix::Base';

sub _add_missing_params
{
    my $self = shift;
    $self->_add_get_params;
    $self->_add_create_params;
}

sub _add_get_params
{
    my $self = shift;
    if( $self->_get_by_name )
    {
        $self->_add_search_pattern;
    }
    if( $self->_get_all )
    {
        $self->_add_get_all;
    }
}

sub _add_create_params
{
    my $self = shift;
    if( $self->_create )
    {
        $self->_add_host;
        $self->_add_groupid;
        $self->_add_templateid;
    }
}

sub _add_search_pattern
{
    my $self = shift;
    if( $self->search )
    {
        my $json = $self->json;
        $json->{'params'}{'output'} = 'extend';
        $json->{'params'}{'select_hosts'} = 'refer';
        $json->{'params'}{'search'} = $self->search;
        $self->json( $json );
    }
}

sub _add_get_all
{
    my $self = shift;
    my $json = $self->json;
    $json->{'params'}{'output'}[0] = 'host';
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
    else
    {
        die 'need hostname';
    }
}

sub _add_groupid
{
    my $self = shift;
    my $json = $self->json;
    if( $self->groups )
    {
        $json->{'params'}{'groups'} = $self->groups;
    }
    $self->json( $json );
}

sub _add_templateid
{
    my $self = shift;
    my $json = $self->json;
    if( $self->templates )
    {
        $json->{'params'}{'templates'} = $self->templates;
    }
    $self->json( $json );
}

has url          => ( is => 'ro', required => 1 );
has authToken    => ( is => 'ro', required => 1 );
has search       => ( is => 'ro' );
has host         => ( is => 'ro' );
has groups       => ( is => 'ro' );
has templates    => ( is => 'ro' );
has _get_by_name => ( is => 'rw' );
has _get_all     => ( is => 'rw' );
has _create      => ( is => 'rw' );
1;
