use strict;
use warnings;
use Test::Deep;
use Test::More;

require_ok 'JSON::TypeInference::Type::Array';
require_ok 'JSON::TypeInference::Type::Boolean';
require_ok 'JSON::TypeInference::Type::Null';
require_ok 'JSON::TypeInference::Type::Number';
require_ok 'JSON::TypeInference::Type::Object';
require_ok 'JSON::TypeInference::Type::String';
require_ok 'JSON::TypeInference';

subtest '#deduce' => sub {
  subtest 'same types' => sub {
    cmp_deeply +JSON::TypeInference->deduce([qw( a b c )]), JSON::TypeInference::Type::String->new;
    cmp_deeply +JSON::TypeInference->deduce([1, 2, 3]), JSON::TypeInference::Type::Number->new;
    cmp_deeply +JSON::TypeInference->deduce([\1, \1]), JSON::TypeInference::Type::Boolean->new;
    cmp_deeply +JSON::TypeInference->deduce([undef, undef]), JSON::TypeInference::Type::Null->new;
    cmp_deeply +JSON::TypeInference->deduce([ [1], [2] ]), isa('JSON::TypeInference::Type::Array') & methods(
      element_type => JSON::TypeInference::Type::Number->new,
    );
  };
};

done_testing;
