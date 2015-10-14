package JSON::TypeInference::Type::Unknown;
use strict;
use warnings;
use parent qw(JSON::TypeInference::Type::Base);

sub new {
  my ($class) = @_;
  return $class->_new(
    name => 'unknown',
  );
}

sub accepts {
  my ($class, $data) = @_;
  return 0;
}

1;
