package Pabbix::HostGroup::Base;

use strict;
use warnings;
use Moo;

sub _add_missing_params
{
    my $self = shift;

    if( $self->_get_by_name )
    {
        $self->_add_name_filter;
    }
    else
    {
        $self->_add_id_filter;
    }
}

sub _add_name_filter
{
    my $self = shift;
    my $json = $self->json;
    $json->{'params'}{'output'} = 'extend';
    if( $self->name )
    {
        $json->{'params'}{'filter'}{'name'} = $self->name;
    }
    $self->json( $json );
}

sub _add_id_filter
{
    my $self = shift;
    my $json = $self->json;
    $json->{'params'}{'output'} = 'extend';
    if( $self->groupid )
    {
        $json->{'params'}{'filter'}{'groupid'} = $self->groupid;
    }
    $self->json( $json );
}

has json         => ( is => 'rw' );
has url          => ( is => 'ro', required => 1 );
has authToken    => ( is => 'ro', required => 1 );
has name         => ( is => 'ro' );
has groupid      => ( is => 'ro' );
has _get_by_name => ( is => 'rw' );
1;
