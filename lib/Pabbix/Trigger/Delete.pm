package Pabbix::Trigger::Delete;

use strict;
use warnings;
use Moo;
use Pabbix::Request;

extends 'Pabbix::Trigger::Base';

sub delete
{
    my $self = shift;
    $self->method( 'trigger.delete' );
    my $response = Pabbix::Request->new(
        url => $self->url,
        json => $self->_createJson,
    );
    return $response->get;
}

1;
