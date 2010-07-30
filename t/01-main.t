use strict;
use warnings;
use Test::More tests => 2;
use Dancer::FileUtils 'path';

use Dancer::Template::Xslate;

my $engine;
eval { $engine = Dancer::Template::Xslate->new };
is $@, '',
  "Dancer::Template::Xslate engine created";

my $template = path('t', 'index.xslate');

my $result = $engine->render(
    $template,
    {   var1 => 1,
        var2 => 2,
        foo  => 'one',
        bar  => 'two',
        baz  => 'three'
    }
);

my $expected =
  'this is var1="1" and var2=2' . "\n\nanother line\n\none two three\n";
is $result, $expected, "processed a template given as a file name";
