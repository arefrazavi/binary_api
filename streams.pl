#!/usr/bin/perl -Ilib
use strict;
use warnings FATAL => 'all';
use BinaryApi;
use Data::Dumper;
use feature 'say';

my $underlying_symbol = "R_100";
#BinaryApi::_get_stream($underlying_symbol);

#BinaryApi::_get_symbols());

my $landing_company = 'costarica';
my $assets = BinaryApi::_get_assets($landing_company);

my $asset_keys = keys %$assets;

say ref($assets->{asset_index});

say "*** List of underlyings (instruments) and their available contract types for  $landing_company landing company ***";
for my $asset_index (@{$assets->{asset_index}}) {
    say "   Underlying Name: " . $asset_index->[0];
    say "   Underlying Symbol: " . $asset_index->[1];
    for my $contract_type (@{$asset_index->[2]}) {
        say "   Contract Type: " . $contract_type->[0];
        say "   Contract Name: " . $contract_type->[1];
        say "   Min Contract Duration: " . $contract_type->[2];
        say "   Max Contract Duration: " . $contract_type->[3] . "\n";
    }
}