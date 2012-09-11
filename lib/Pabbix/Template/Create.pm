package Pabbix::Template::Create;

use strict;
use warnings;
use Moo;
use Pabbix::Request;
use Data::Dumper;

extends 'Pabbix::Template::Base';

sub create
{
    my $self = shift;
    $self->_create( 1 );
    my $response = Pabbix::Request->new(
        url => $self->url,
        json => $self->_createJson,
    );
    print Dumper $self->json;
    return $response->get;
}

sub _createJson
{
    my $self = shift;
    $self->json(
        {
            jsonrpc => "2.0",
            method  => "template.create",
            auth    => $self->authToken,
            id      => 0
        }
    );
    $self->_add_missing_params;
    return $self->json;
}

1;
