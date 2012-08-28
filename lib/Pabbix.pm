package Pabbix;

use 5.012004;
use strict;
use warnings;
use LWP::UserAgent;
use Data::Dumper;
use JSON::XS;

require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Pabbix ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	
);

our $VERSION = '0.01';

sub makeReq
{
    my ( $url, $json ) = @_;
    my $req = HTTP::Request->new( POST => $url );
    $req->content( encode_json( $json ) );
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

sub getAuthToken
{
    my ( $url, $user, $passwd ) = @_;
    my $json = {
        jsonrpc => "2.0",
        method  => "user.authenticate",
        params  => {
            user     => $user,
            password => $passwd
        },
        id      => "0"
    };

    my $response = makeReq( $url, $json );
    return $response->{"result"};
}

sub getTrigger
{
    my ( $url, $authToken ) = @_;
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
        auth => $authToken,
        id   => 0
    };

    my $response = makeReq( $url, $json );
    return $response;
}

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Pabbix - Perl extension for blah blah blah

=head1 SYNOPSIS

  use Pabbix;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for Pabbix, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Indeed! He was ! :D

Blah blah blah.

=head2 EXPORT

None by default.



=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

A. U. Thor, E<lt>roa@(none)E<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2012 by A. U. Thor

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.12.4 or,
at your option, any later version of Perl 5 you may have available.


=cut
