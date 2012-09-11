package Pabbix::Template::Get;

use strict;
use warnings;
use Moo;
use Pabbix::Request;

extends 'Pabbix::Template::Base';

sub get_by_name
{
    my $self = shift;
    $self->method( 'template.get' );
    $self->_get_by_name( 1 );
    my $response = Pabbix::Request->new(
        url => $self->url,
        json => $self->_createJson,
    );
    return $response->get;
}

sub get_all
{
    my $self = shift;
    $self->method( 'template.get' );
    $self->_get_all( 1 );
    my $response = Pabbix::Request->new(
        url => $self->url,
        json => $self->_createJson,
    );
    return $response->get;
}

1;
