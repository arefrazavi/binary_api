package BinaryApi;
use strict;
use warnings FATAL => 'all';
use Mojo::UserAgent;
use Data::Dumper;
use feature 'say';

sub _show_stream {
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


sub _get_symbols {
    my ($active_symbols) = @_;
    my $ua = Mojo::UserAgent->new;
    my $symbols;

    $ua->websocket('wss://ws.binaryws.com/websockets/v3?app_id=16047' => sub {
        my ($ua, $tx) = @_;
        unless ($tx->is_websocket) {
            say 'WebSocket handshake failed!';
            return;
        }

        $tx->on(json => sub {
            my ($tx, $result) = @_;
            $symbols = $result;
        });

        $tx->send({ json => {
            active_symbols => $active_symbols || 'full'
        } });

    });

    Mojo::IOLoop->start unless Mojo::IOLoop->is_running;
    Mojo::IOLoop->stop;

    return $symbols;

}

sub _get_assets {
    my ($landing_company) = @_;
    my $ua = Mojo::UserAgent->new;
    my $assets;

    $ua->websocket('wss://ws.binaryws.com/websockets/v3?app_id=16047' => sub {
        my ($ua, $tx) = @_;
        unless ($tx->is_websocket) {
            say 'WebSocket handshake failed!';
            return;
        }

        $tx->on(json => sub {
            my ($tx, $result) = @_;
            $assets = $result;
        });

        my $request = ($landing_company) ? {asset_index => 1, landing_company => $landing_company} : {asset_index => 1};

        $tx->send({ json => $request });

    });


    Mojo::IOLoop->start unless Mojo::IOLoop->is_running;

    return $assets;

}

1;

