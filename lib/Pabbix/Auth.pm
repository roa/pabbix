package Pabbix::Auth;

use strict;
use warnings;
use Moo;
use Pabbix::Request;

sub get
{
    my $self = shift;
    my $json = {
        jsonrpc => "2.0",
        method  => "user.authenticate",
        params  => {
            user     => $self->user,
            password => $self->passwd
        },
        id      => "0"
    };

    my $response = Pabbix::Request->new(
        url => $self->url,
        json => $json,
    );
    return $response->makeReq()->{'result'};
}

has url => (
    is => 'ro',
);

has user => (
    is => 'ro',
);

has passwd => (
    is => 'ro',
);

1;
