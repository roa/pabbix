package Pabbix::Template::Base;

use strict;
use warnings;
use Moo;


sub _add_missing_params
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

has json      => ( is => 'rw' );
has url       => ( is => 'ro', required => 1 );
has authToken => ( is => 'ro', required => 1 );
has search    => ( is => 'ro' );

has _get_by_name => ( is => 'rw' );
has _get_all     => ( is => 'rw' );

1;
