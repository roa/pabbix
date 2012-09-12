package Pabbix::HostGroup::Base;

use strict;
use warnings;
use Moo;

extends 'Pabbix::Base';

sub _add_missing_params
{
    my $self = shift;
    if( $self->method eq 'hostgroup.get' )
    {
        if( $self->_get_by_name )
        {
            $self->_add_name_filter;
        }
        elsif( $self->_get_by_id )
        {
            $self->_add_id_filter;
        }
        else
        {
            $self->_add_output;
        }
    }
    elsif( $self->method eq 'hostgroup.create' )
    {
    }
}

sub _add_name_filter
{
    my $self = shift;
    $json->{'params'}{'output'} = 'extend';
    if( $self->name )
    {
        my $json = $self->json;
        $json->{'params'}{'filter'}{'name'} = $self->name;
        $self->json( $json );
    }
}

sub _add_id_filter
{
    my $self = shift;
    $json->{'params'}{'output'} = 'extend';
    if( $self->groupid )
    {
        my $json = $self->json;
        $json->{'params'}{'filter'}{'groupid'} = $self->groupid;
        $self->json( $json );
    }
}

sub _add_output
{
    my $self = shift;
    my $json = $self->json;
    $json->{'params'}{'output'} = 'extend';
    $self->json( $json );
}

has url          => ( is => 'ro', required => 1 );
has authToken    => ( is => 'ro', required => 1 );
has name         => ( is => 'ro' );
has groupid      => ( is => 'ro' );
has _get_by_name => ( is => 'rw' );
has _get_by_id   => ( is => 'rw' );
has _create      => ( is => 'rw' );
1;
