package Pabbix::Base;

use strict;
use warnings;
use Moo;

sub _createJson
{
    my $self = shift;
    $self->json(
        {
            jsonrpc => "2.0",
            method  => $self->method,
            auth    => $self->authToken,
            id      => 0
        }
    );
    $self->_add_missing_params;
    return $self->json;
}

has json   => ( is => 'rw' );
has method => ( is => 'rw' );

1;
