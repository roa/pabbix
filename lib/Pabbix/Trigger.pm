package Pabbix::Trigger;

use strict;
use warnings;
use Moo;
use Pabbix::Request;

sub getTrigger
{
    my $self = shift;
    my $json = {
        jsonrpc => "2.0",
        method  => "trigger.get",
        params  => {
            output     => "extend",
            expandData => "host",
            filter     => {
                value => 1
            }
        },
        auth => $self->authToken,
        id   => 0
    };

    my $response = Pabbix::Request->new(
        url => $self->url,
        json => $json,
    );
    return $response->makeReq();
}

has url => (
    is => 'ro',
);

has authToken => (
    is => 'ro',
);

1;
