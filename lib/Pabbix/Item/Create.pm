package Pabbix::Item::Create;

use strict;
use warnings;
use Moo;
use Pabbix::Request;

extends 'Pabbix::Item::Base';

sub create
{
    my $self = shift;
    $self->method( 'item.create' );
    my $response = Pabbix::Request->new(
        url => $self->url,
        json => $self->_createJson,
    );
    return $response->get();
}

1;
