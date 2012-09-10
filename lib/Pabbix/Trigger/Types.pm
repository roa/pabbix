package Pabbix::Trigger::Types;

use strict;
use warnings;
use Moo;

sub _add_missing_params
{
    my $self = shift;
    my $json = $self->json;
    if( $self->statusValue )
    {
        $json->{'params'}{'status'} = $self->statusValue;
    }
    if( $self->hostid )
    {
        $json->{'params'}{'hostid'} = $self->hostid;
    }
    if( $self->host )
    {
        $json->{'params'}{'host'} = $self->host;
    }
    if( $self->description )
    {
        $json->{'params'}{'description'} = $self->description;
    }
    if( $self->expression )
    {
        $json->{'params'}{'expression'} = $self->expression;
    }
    if( $self->nodeids )
    {
        $json->{'params'}{'nodeids'} = $self->nodeids;
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

has statusValue => (
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
);

has expression => (
    is => 'ro',
);

has nodeids => (
    is => 'ro',
);

1;
