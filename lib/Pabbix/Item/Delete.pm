package Pabbix::Item::Delete;

use strict;
use warnings;
use Moo;
use Pabbix::Request;

extends 'Pabbix::Item::Base';

sub delete
{
    my $self = shift;
    $self->method( 'item.delete' );
    my $response = Pabbix::Request->new(
        url => $self->url,
        json => $self->_createJson,
    );
    return $response->get();
}

1;
