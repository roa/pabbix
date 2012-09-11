package Pabbix::Host::Create;

use strict;
use warnings;
use Moo;
use Pabbix::Request;

extends 'Pabbix::Host::Base';

sub create
{
    my $self = shift;
    $self->method( 'host.create' );
    my $response = Pabbix::Request->new(
        url => $self->url,
        json => $self->_createJson,
    );
    return $response->get;
}

1;
