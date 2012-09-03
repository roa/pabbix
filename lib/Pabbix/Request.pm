package Pabbix::Request;

use strict;
use warnings;
use Moo;
use LWP::UserAgent;
use JSON::XS;

sub makeReq
{
    my $self = shift;
    my $req = HTTP::Request->new( POST => ($self->url) );
    $req->content( encode_json( $self->json ) );
    my $ua = LWP::UserAgent->new;
    $ua->timeout(10);

    $req->content_type( 'application/json-rpc' );
    my $response = $ua->request($req);
    if( $response->is_success )
    {
        return decode_json( $response->decoded_content );
    }
    else
    {
        die $response->status_line;
    }
}

has url => (
    is => 'ro',
);

has json => (
    is => 'ro'
);

1;
