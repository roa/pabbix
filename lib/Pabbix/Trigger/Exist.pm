package Pabbix::Trigger::Exist;

use strict;
use warnings;
use Moo;
use Pabbix::Request;
use Data::Dumper;

sub exist
{
    my $self = shift;

    my $response = Pabbix::Request->new(
        url => $self->url,
        json => $self->_createJson,
    );
    return $response->get;
}

sub _createJson
{
    my $self = shift;
    my $json = {
        jsonrpc => "2.0",
        method  => "trigger.exists",
        params  => {
            description => $self->description,
            expression => $self->expression,
        },
        auth    => $self->authToken,
        id      => 0
    };

    if( $self->hostid )
    {
        $json->{'params'}{'hostid'} = $self->hostid;
    }
    if( $self->host )
    {
        $json->{'params'}{'host'} = $self->host;
    }
    if( $self->nodeids )
    {
        $json->{'params'}{'nodeids'} = $self->nodeids;
    }

    return $json;
}

has url => (
    is => 'ro',
);

has authToken => (
    is => 'ro',
);

has host => (
    is => 'ro',
);

has hostid => (
    is => 'ro',
);

has description => (
    is => 'ro',
    required => 1,
);

has expression => (
    is => 'ro',
    required => 1,
);

has nodeids => (
    is => 'ro',
);

1;
