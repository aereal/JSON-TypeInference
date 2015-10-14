package JSON::TypeInference::Type::Object;
use strict;
use warnings;
use parent qw(JSON::TypeInference::Type);

sub new {
  my ($class) = @_;
  return $class->_new(
    name => 'object',
  );
}

sub accepts {
  my ($class, $data) = @_;
  return ref($data) eq 'HASH';
}

1;
