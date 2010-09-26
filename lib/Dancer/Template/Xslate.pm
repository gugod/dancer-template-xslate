package Dancer::Template::Xslate;

# ABSTRACT: Text::Xslate wrapper for Dancer

use strict;
use warnings;

use Text::Xslate;

use base 'Dancer::Template::Abstract';

my $_engine;

sub init {
    my $self = shift;

    my %args = (
        %{$self->config},
    );

    $_engine = Text::Xslate->new(%args);
}

sub render {
    my ($self, $template, $tokens) = @_;

    my $content = eval {
        $_engine->render($template, $tokens)
    };

    if (my $err = $@) {
        my $error = qq/Couldn't render template "$err"/;
        die $error;
    }

    return $content;
}

1;

=head1 DESCRIPTION

This class is an interface between Dancer's template engine abstraction layer
and the L<Text::Xslate> module.

In order to use this engine, use the template setting:

    template: xslate

This can be done in your config.yml file or directly in your app code with the
B<set> keyword.

You can configure L<Text::Xslate> :

    template: xslate
    engines:
      xslate:
        cache_dir  => "/www/../xslate_cache",
        cache      => 1,
        module =>
          - Text::Xslate::Bridge::TT2 # to keep partial compatibility


=head1 SEE ALSO

L<Dancer>, L<Text::Xslate>, L<http://xslate.org/>
