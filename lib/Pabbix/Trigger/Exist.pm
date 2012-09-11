package Pabbix::Trigger::Exist;

use strict;
use warnings;
use Moo;
use Pabbix::Request;

extends 'Pabbix::Trigger::Base';

sub exist
{
    my $self = shift;
    $self->method( 'trigger.exists' );
    my $response = Pabbix::Request->new(
        url => $self->url,
        json => $self->_createJson,
    );
    return $response->get;
}

1;
