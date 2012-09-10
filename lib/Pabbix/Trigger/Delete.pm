package Pabbix::Trigger::Delete;

use strict;
use warnings;
use Moo;
use Pabbix::Request;

extends 'Pabbix::Trigger::Types';

sub delete
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
            method  => "trigger.delete",
            params  => $self->triggerids,
            auth    => $self->authToken,
            id      => 0
        }
    );
    return $self->json;
}

has triggerids => (
    is => 'ro',
);

1;
