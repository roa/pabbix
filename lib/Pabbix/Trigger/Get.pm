package Pabbix::Trigger::Get;

use strict;
use warnings;
use Moo;
use Pabbix::Request;
use Pabbix::Trigger::Trigger;

sub get
{
    my $self = shift;
    my $response = Pabbix::Request->new(
        url => $self->url,
        json => $self->_createJson,
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

sub _createJson
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
    return $json;
}

#has url => (
#    is => 'ro',
#    required => 1,
#);

#has authToken => (
#    is => 'ro',
#    required => 1,
#);



1;
