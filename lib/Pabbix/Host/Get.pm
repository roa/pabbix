package Pabbix::Host::Get;

use strict;
use warnings;
use Moo;
use Pabbix::Request;

extends 'Pabbix::Host::Base';

sub get
{
    my $self = shift;
    $self->method( 'host.get' );    
    $self->filter( 1 );

    my $response = Pabbix::Request->new(
        url => $self->url,
        json => $self->_createJson,
    );
    return $response->get;
}

1;
