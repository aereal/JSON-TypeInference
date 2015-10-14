package JSON::TypeInference::Type::Boolean;
use strict;
use warnings;
use parent qw(JSON::TypeInference::Type);

sub new {
  my ($class) = @_;
  return $class->_new(
    name => 'boolean',
  );
}

sub accepts {
  my ($class, $data) = @_;
  return (ref($data) eq 'SCALAR') && ($$data == 0 || $$data == 1);
}

1;
