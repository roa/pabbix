package Pabbix::HostGroup::Get;

use strict;
use warnings;
use Moo;
use Pabbix::Request;
use Data::Dumper;

extends 'Pabbix::HostGroup::Base';

sub get_by_name
{
    my $self = shift;
    $self->method( 'hostgroup.get' );    
    $self->_get_by_name( 1 );
    my $response = Pabbix::Request->new(
        url => $self->url,
        json => $self->_createJson,
    );
    return $response->get;

}

sub get_by_id
{
    my $self = shift;
    $self->method( 'hostgroup.get' );    
    $self->_get_by_id( 1 );
    my $response = Pabbix::Request->new(
        url => $self->url,
        json => $self->_createJson,
    );
    return $response->get;
}

sub get_all
{
    my $self = shift;
    $self->method( 'hostgroup.get' );    
    my $response = Pabbix::Request->new(
        url => $self->url,
        json => $self->_createJson,
    );
    return $response->get;
}

1;
