package JSON::TypeInference::Type::Boolean;
use strict;
use warnings;

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
  return (ref($data) eq 'SCALAR') && ($$data == 0 || $$data == 1);
}

1;
