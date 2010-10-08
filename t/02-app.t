use strict;
use warnings;
use Test::More import => ["!pass"];

use Dancer ':syntax';
use Dancer::Test;

plan tests => 3;

setting template => 'xslate';
setting views   => 't';

ok(
    get '/' => sub {
        template 'index', { loop => [1..2] };
    }
);

route_exists [ GET => '/' ];
response_content_like( [ GET => '/' ], qr/1<br \/>\n2/ );
