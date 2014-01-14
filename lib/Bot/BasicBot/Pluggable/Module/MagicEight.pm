package Bot::BasicBot::Pluggable::Module::MagicEight;

# Implementation of a Magic 8-Ball in bot form.

use strict;
no warnings;
use base 'Bot::BasicBot::Pluggable::Module';

=head1 NAME

Bot::BasicBot::Pluggable::Module::MagicEight - Magic-8 Ball in your IRC!

=head1 DESCRIPTION

B:B:P Implementation of a somewhat adult Magic 8 Ball.

Please be aware the responses in this module contain expletives. Do not use
this module in bots that are to be in channels with sensitive individuals.

=cut

my $capture_regex = qr/^!(8-?ball|eightball|magiceight|magic8)/;
my %responses = (
    'Yes' => [
        'Yes!',
        'Definitely!',
        'Sure',
        'I think so',
        'Fuck yeah!',
        'Hell yeah!',
        'Most certainly',
        'For sure',
        'Abso-fucking-lutely',
        'In-fucking-deed!',
        'Fuck yes',
    ],
    'No' => [
        'Nope',
        'No way!',
        'Of course not you pleb!',
        'I think not',
        'Negative',
        'Not a chance!',
        'Good God no!',
        'Absolutely no chance!',
        "You're kidding, right?",
        'No fucking chance',
    ],
    'Maybe' => [
        'Hmm, perhaps',
        'I suppose',
        'I don\'t know about that',
        'Not sure',
        'Ask me later',
        'How should I know?',
        "Haven't a fucking clue",
    ],
);

sub help {
    return <<HELP;
8-Ball Usage (One of):
    !8ball <question>
    !8-ball <question>
    !eightball <question>
    !magiceight <question>
    !magic8 <question>
HELP
}

sub said {
    my ($self, $message, $priority) = @_;

    my $body = $message->{body};
    return unless $priority == 2;
    return unless $body =~ $capture_regex;

    # If we get here, we've captured a message format to be processed by us.

    # First, if we were asked to pick from some options:
    if (my($option_list) = $body =~ /(?:choose|pick) \s+ (?:from\s+)? (.+)/x) {
        my @options = split /\s+or\s+/, $option_list;
        my $picked = $options[ rand @options ];
        return "8ball picked: $picked";
    }

    # Otherwise, make a decision, possibly influenced a little :)
    my $result;
    if ($body =~ / (?: alcohol | beer | pub | home | friday ) /xi) {
        $result = 'Yes';
    } elsif ($body =~ / (?: cpai?nel | windows | exchange | work ) /xi) {
        $result = 'No';
    } else {
        $result = (rand() < 0.3) ? 'Maybe' : (rand() < 0.5) ? 'Yes' : 'No';
    }
    if ($body =~ / (?: suck | fail | shit | fucked ) /xi) {
        $result = { 'Yes' => 'No', 'No' => 'Yes' }->{$result} || $result;
    }
    my $response = $responses{$result}[rand @{ $responses{$result} }];

    return "8ball: $response";
}

1;

