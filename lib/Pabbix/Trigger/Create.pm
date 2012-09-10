package Pabbix::Trigger::Create;

use strict;
use warnings;
use Moo;
use Pabbix::Request;

extends 'Pabbix::Trigger::Base';

sub create
{
    my $self = shift;

    my $response = Pabbix::Request->new(
        url  => $self->url,
        json =>$self->_createJson,
    );
    return $response->get();
}

sub _createJson
{
    my $self = shift;

    $self->json(
        {
            jsonrpc => "2.0",
            method  => "trigger.create",
            auth    => $self->authToken,
            id      => 0
        }
    );
    $self->_add_missing_params;
    return $self->json;
}

1;
