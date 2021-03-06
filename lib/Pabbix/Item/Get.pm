package Pabbix::Item::Get;

use strict;
use warnings;
use Moo;
use Pabbix::Request;

extends 'Pabbix::Item::Base';

sub get
{
    my $self = shift;
    $self->method( 'item.get' );    
    my $response = Pabbix::Request->new(
        url => $self->url,
        json => $self->_createJson
    );
    return $response->get;
}

1;
