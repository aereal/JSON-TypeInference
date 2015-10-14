package JSON::TypeInference::Type::Array;
use strict;
use warnings;
use parent qw(JSON::TypeInference::Type);

sub new {
  my ($class) = @_;
  return $class->_new(
    name => 'array',
  );
}

sub accepts {
  my ($class, $data) = @_;
  return ref($data) eq 'ARRAY';
}

1;
