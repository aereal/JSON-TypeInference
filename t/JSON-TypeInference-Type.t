use strict;
use warnings;
use Test::More;
use Types::Serialiser;

require_ok 'JSON::TypeInference::Type::Array';
require_ok 'JSON::TypeInference::Type::Boolean';
require_ok 'JSON::TypeInference::Type::Maybe';
require_ok 'JSON::TypeInference::Type::Null';
require_ok 'JSON::TypeInference::Type::Number';
require_ok 'JSON::TypeInference::Type::Object';
require_ok 'JSON::TypeInference::Type::String';
require_ok 'JSON::TypeInference::Type::Union';
require_ok 'JSON::TypeInference::Type::Unknown';

subtest '#accepts' => sub {
  subtest 'string' => sub {
    ok + JSON::TypeInference::Type::String->accepts('a');
    ok ! JSON::TypeInference::Type::String->accepts(1);
    ok ! JSON::TypeInference::Type::String->accepts(\1);
    ok ! JSON::TypeInference::Type::String->accepts(\0);
    ok ! JSON::TypeInference::Type::String->accepts([]);
    ok ! JSON::TypeInference::Type::String->accepts({});
    ok ! JSON::TypeInference::Type::String->accepts(undef);
  };

  subtest 'number' => sub {
    ok ! JSON::TypeInference::Type::Number->accepts('a');
    ok + JSON::TypeInference::Type::Number->accepts(1);
    ok ! JSON::TypeInference::Type::Number->accepts(\1);
    ok ! JSON::TypeInference::Type::Number->accepts(\0);
    ok ! JSON::TypeInference::Type::Number->accepts([]);
    ok ! JSON::TypeInference::Type::Number->accepts({});
    ok ! JSON::TypeInference::Type::Number->accepts(undef);
  };

  subtest 'null' => sub {
    ok ! JSON::TypeInference::Type::Null->accepts('a');
    ok ! JSON::TypeInference::Type::Null->accepts(1);
    ok ! JSON::TypeInference::Type::Null->accepts(\1);
    ok ! JSON::TypeInference::Type::Null->accepts(\0);
    ok ! JSON::TypeInference::Type::Null->accepts([]);
    ok ! JSON::TypeInference::Type::Null->accepts({});
    ok + JSON::TypeInference::Type::Null->accepts(undef);
  };

  subtest 'array' => sub {
    ok ! JSON::TypeInference::Type::Array->accepts('a');
    ok ! JSON::TypeInference::Type::Array->accepts(1);
    ok ! JSON::TypeInference::Type::Array->accepts(\1);
    ok ! JSON::TypeInference::Type::Array->accepts(\0);
    ok + JSON::TypeInference::Type::Array->accepts([]);
    ok ! JSON::TypeInference::Type::Array->accepts({});
    ok ! JSON::TypeInference::Type::Array->accepts(undef);
  };

  subtest 'object' => sub {
    ok ! JSON::TypeInference::Type::Object->accepts('a');
    ok ! JSON::TypeInference::Type::Object->accepts(1);
    ok ! JSON::TypeInference::Type::Object->accepts(\1);
    ok ! JSON::TypeInference::Type::Object->accepts(\0);
    ok ! JSON::TypeInference::Type::Object->accepts([]);
    ok + JSON::TypeInference::Type::Object->accepts({});
    ok ! JSON::TypeInference::Type::Object->accepts(undef);
  };

  subtest 'boolean' => sub {
    ok ! JSON::TypeInference::Type::Boolean->accepts('a');
    ok ! JSON::TypeInference::Type::Boolean->accepts(1);
    ok ! JSON::TypeInference::Type::Boolean->accepts(\(my $str = 'str'));
    ok + JSON::TypeInference::Type::Boolean->accepts(Types::Serialiser::true);
    ok + JSON::TypeInference::Type::Boolean->accepts(Types::Serialiser::false);
    ok ! JSON::TypeInference::Type::Boolean->accepts([]);
    ok ! JSON::TypeInference::Type::Boolean->accepts({});
    ok ! JSON::TypeInference::Type::Boolean->accepts(undef);
  };

  subtest 'maybe' => sub {
    ok ! JSON::TypeInference::Type::Maybe->accepts('a');
    ok ! JSON::TypeInference::Type::Maybe->accepts(1);
    ok ! JSON::TypeInference::Type::Maybe->accepts(\1);
    ok ! JSON::TypeInference::Type::Maybe->accepts(\0);
    ok ! JSON::TypeInference::Type::Maybe->accepts([]);
    ok ! JSON::TypeInference::Type::Maybe->accepts({});
    ok ! JSON::TypeInference::Type::Maybe->accepts(undef);
  };

  subtest 'union' => sub {
    ok ! JSON::TypeInference::Type::Union->accepts('a');
    ok ! JSON::TypeInference::Type::Union->accepts(1);
    ok ! JSON::TypeInference::Type::Union->accepts(\1);
    ok ! JSON::TypeInference::Type::Union->accepts(\0);
    ok ! JSON::TypeInference::Type::Union->accepts([]);
    ok ! JSON::TypeInference::Type::Union->accepts({});
    ok ! JSON::TypeInference::Type::Union->accepts(undef);
  };

  subtest 'unknown' => sub {
    ok ! JSON::TypeInference::Type::Unknown->accepts('a');
    ok ! JSON::TypeInference::Type::Unknown->accepts(1);
    ok ! JSON::TypeInference::Type::Unknown->accepts(\1);
    ok ! JSON::TypeInference::Type::Unknown->accepts(\0);
    ok ! JSON::TypeInference::Type::Unknown->accepts([]);
    ok ! JSON::TypeInference::Type::Unknown->accepts({});
    ok ! JSON::TypeInference::Type::Unknown->accepts(undef);
  };
};

done_testing;
