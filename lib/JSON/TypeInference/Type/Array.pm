package JSON::TypeInference::Type::Array;
use strict;
use warnings;

sub new {
  my ($class, $element_type) = @_;
  return bless { element_type => $element_type }, $class;
}

sub name {
  my ($class) = @_;
  return 'array';
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
