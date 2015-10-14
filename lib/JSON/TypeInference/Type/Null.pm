package JSON::TypeInference::Type::Null;
use strict;
use warnings;
use parent qw(JSON::TypeInference::Type);

sub new {
  my ($class) = @_;
  return $class->_new(
    name => 'null',
  );
}

sub accepts {
  my ($class, $data) = @_;
  return !defined($data);
}

1;
