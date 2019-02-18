package BinaryApi;
use strict;
use warnings FATAL => 'all';
use Mojo::UserAgent;
use Data::Dumper;
use feature 'say';

sub get_stream {
    my ($underlying_symbol) = @_;
    my $ua = Mojo::UserAgent->new;

    $ua->websocket('wss://ws.binaryws.com/websockets/v3?app_id=16047' => sub {
        my ($ua, $tx) = @_;
        unless ($tx->is_websocket) {
            say 'WebSocket handshake failed!';
            return;
        }

        $tx->on(json => sub {
            my ($tx, $result) = @_;
            say Dumper(\$result);
        });

        $tx->send({ json => {
            ticks => $underlying_symbol
        } });
    });
    Mojo::IOLoop->start unless Mojo::IOLoop->is_running;
}

1;

