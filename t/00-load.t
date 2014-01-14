#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'Bot::BasicBot::Pluggable::Module::MagicEight' ) || print "Bail out!\n";
}

diag( "Testing Bot::BasicBot::Pluggable::Module::MagicEight $Bot::BasicBot::Pluggable::Module::MagicEight::VERSION, Perl $], $^X" );
