package Pabbix::Item::Base;

use strict;
use warnings;
use Moo;

extends 'Pabbix::Base';

sub _add_missing_params
{
    my $self = shift;
    if( $self->search )
    {
        $self->_add_search_pattern;
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

has url => ( is => 'ro', required => 1 );
has authToken => ( is => 'ro', required => 1 );
has search => ( is => 'ro' );

1;
