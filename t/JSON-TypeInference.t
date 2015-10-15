use strict;
use warnings;
use Test::Deep qw(cmp_deeply);
use Test::More;
use Test::JSON::TypeInference::Matcher;

require_ok 'JSON::TypeInference::Type::Array';
require_ok 'JSON::TypeInference::Type::Boolean';
require_ok 'JSON::TypeInference::Type::Null';
require_ok 'JSON::TypeInference::Type::Number';
require_ok 'JSON::TypeInference::Type::Object';
require_ok 'JSON::TypeInference::Type::String';
require_ok 'JSON::TypeInference::Type::Union';
require_ok 'JSON::TypeInference';

subtest '#infer' => sub {
  subtest 'same types' => sub {
    cmp_deeply +JSON::TypeInference->infer([qw( a b c )]), string;
    cmp_deeply +JSON::TypeInference->infer([1, 2, 3]), number;
    cmp_deeply +JSON::TypeInference->infer([\1, \1]), boolean;
    cmp_deeply +JSON::TypeInference->infer([undef, undef]), null;
    cmp_deeply +JSON::TypeInference->infer([ [1], [2] ]), array number;
  };
  subtest 'union' => sub {
    cmp_deeply +JSON::TypeInference->infer([ 1, 'a' ]), union number, string;
    cmp_deeply +JSON::TypeInference->infer([ 1, [1] ]), union array(number), number;
  };
  subtest 'unknown' => sub {
    cmp_deeply +JSON::TypeInference->infer([ bless({}, 't::Blessed') ]), unknown;
  };
  subtest 'object' => sub {
    cmp_deeply +JSON::TypeInference->infer([ { id => 1, is_ok => \1 }, { id => 2, is_ok => \0 } ]), object(
      id    => number,
      is_ok => boolean,
    );
  };
};

done_testing;
