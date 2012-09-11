package Pabbix::Host::Get;

use strict;
use warnings;
use Moo;
use Pabbix::Request;

extends 'Pabbix::Host::Base';

sub get
{
    my $self = shift;
    $self->filter( 1 );

    my $response = Pabbix::Request->new(
        url => $self->url,
        json => $self->_createJson,
    );
    return $response->get;
}

sub _createJson
{
    my $self = shift;

    $self->json(
        {
            jsonrpc => "2.0",
            method  => "host.get",
            auth    => $self->authToken,
            id      => 0
        }
    );
    $self->_add_missing_params;
    return $self->json;
}

1;
