package JSON::TypeInference::Type::Object;
use strict;
use warnings;
use parent qw(JSON::TypeInference::Type::Base);

sub new {
  my ($class, $properties) = @_;
  return $class->_new(
    name       => 'object',
    properties => $properties,
  );
}

sub properties {
  my ($self) = @_;
  return $self->{properties};
}

sub accepts {
  my ($class, $data) = @_;
  return ref($data) eq 'HASH';
}

1;
