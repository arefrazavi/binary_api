#!/usr/bin/perl -Ilib
use strict;
use warnings FATAL => 'all';
use BinaryApi;
use Data::Dumper;

my $underlying_symbol = "R_100";
BinaryApi::get_stream($underlying_symbol);

