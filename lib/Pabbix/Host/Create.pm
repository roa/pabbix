package Pabbix::Host::Create;

use strict;
use warnings;
use Moo;
use Pabbix::Request;
use Data::Dumper;

extends 'Pabbix::Host::Types';

sub create
{
    my $self = shift;

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
            method  => "host.create",
            auth    => $self->authToken,
            id      => 0
        }
    );
    $self->json( $self->_add_missing_params );
    print Dumper $self->json;
    return $self->json;
}

1;
