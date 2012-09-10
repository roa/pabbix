package Pabbix::Host::Types;

use strict;
use warnings;
use Moo;

sub _add_missing_params
{
    my $self = shift;
    my $json = $self->json;
    if( $self->host )
    {
        $json->{'params'}{'host'} = $self->host;
    }
    if( $self->ip )
    {
        $json->{'params'}{'ip'} = $self->ip;
    }
    if( $self->port )
    {
        $json->{'params'}{'port'} = $self->port;
    }
    else
    {
        $json->{'params'}{'port'} = '10050';
    }
    if( $self->useip )
    {
        $json->{'params'}{'useip'} = 1;
    }
    else
    {
        $json->{'params'}{'useip'} = 0;
    }
    if( $self->groups )
    {
        $json->{'params'}{'groups'} = $self->groups;
    }
    else
    {
        $json->{'params'}{'groups'}[0]{"groupid"} = 1;
    }

    return $json;
}

has json => (
    is => 'rw',
);

has url => (
    is => 'ro',
    required => 1,
);

has authToken => (
    is => 'ro',
    required => 1,
);

has host => (
    is => 'ro',
);

has ip => (
    is => 'ro',
);

has port => (
    is => 'ro',
);

has useip => (
    is => 'ro',
);

has groups => (
    is => 'ro',
);

1;
