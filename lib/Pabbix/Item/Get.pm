package Pabbix::Item::Get;

use strict;
use warnings;
use Moo;
use Pabbix::Request;

extends 'Pabbix::Item::Base';

sub get
{
    my $self = shift;
    
    my $response = Pabbix::Request->new(
        url => $self->url,
        json => $self->_createJson
    );
    return $response->get;
}

sub _createJson
{
    my $self = shift;

    $self->json(
        {
            jsonrpc => "2.0",
            method  => "item.get",
            auth    => $self->authToken,
            id      => 0
        }
    );
    $self->_add_missing_params;
    return $self->json;
}

1;
