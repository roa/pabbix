package Pabbix::Trigger::Get;

use strict;
use warnings;
use Moo;
use Pabbix::Request;

extends 'Pabbix::Trigger::Base';

sub get
{
    my $self = shift;
    $self->method( 'trigger.get' );
    my $response = Pabbix::Request->new(
        url => $self->url,
        json => $self->_createJson,
    );
    return $response->get();
}

1;
