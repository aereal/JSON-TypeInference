package JSON::TypeInference::Type::Array;
use strict;
use warnings;
use parent qw(JSON::TypeInference::Type::Base);

sub new {
  my ($class, $element_type) = @_;
  return $class->_new(
    name         => 'array',
    element_type => $element_type,
  );
}

# => Type
sub element_type {
  my ($self) = @_;
  return $self->{element_type};
}

sub accepts {
  my ($class, $data) = @_;
  return ref($data) eq 'ARRAY';
}

1;
