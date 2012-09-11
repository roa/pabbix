package Pabbix::Trigger::Create;

use strict;
use warnings;
use Moo;
use Pabbix::Request;

extends 'Pabbix::Trigger::Base';

sub create
{
    my $self = shift;
    $self->method( 'trigger.create' );
    my $response = Pabbix::Request->new(
        url  => $self->url,
        json =>$self->_createJson,
    );
    return $response->get();
}

1;
