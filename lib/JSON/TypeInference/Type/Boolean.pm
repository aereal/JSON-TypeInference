package JSON::TypeInference::Type::Boolean;
use strict;
use warnings;

use Types::Serialiser;

sub new {
  my ($class) = @_;
  return bless {}, $class;
}

sub name {
  my ($class) = @_;
  return 'boolean';
}

sub accepts {
  my ($class, $data) = @_;
  return Types::Serialiser::is_bool($data);
}

1;
