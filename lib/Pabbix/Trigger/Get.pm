package Pabbix::Trigger::Get;

use strict;
use warnings;
use Moo;
use Pabbix::Request;

sub get
{
    my $self = shift;
    my $json = {
        jsonrpc => "2.0",
        method  => "trigger.get",
        params  => {
            output     => "extend",
            expandData => "host",
            filter     => {
                value => $self->_translateStatus,
            }
        },
        auth => $self->authToken,
        id   => 0
    };

    my $response = Pabbix::Request->new(
        url => $self->url,
        json => $json,
    );
    return $response->get();
}

sub _translateStatus
{
    my $self = shift;
    if( ! defined( $self->statusValue ) || $self->statusValue eq 'PROBLEM' )
    {
        return 1;
    }
    elsif( $self->statusValue eq 'OK' )
    {
        return 0;
    }
    elsif( $self->statusValue eq 'UNKNOWN' )
    {
        return 2;
    }
    else
    {
        die 'unknown status code';
    }
}

has url => (
    is => 'ro',
);

has authToken => (
    is => 'ro',
);

has statusValue => (
    is => 'ro',
);

1;
