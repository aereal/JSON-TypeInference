package JSON::TypeInference::Type::Object;
use strict;
use warnings;
use parent qw(JSON::TypeInference::Type::Base);

sub new {
  my ($class, $key_type, $value_type) = @_;
  return $class->_new(
    name       => 'object',
    key_type   => $key_type,
    value_type => $value_type,
  );
}

sub key_type {
  my ($self) = @_;
  return $self->{key_type};
}

sub value_type {
  my ($self) = @_;
  return $self->{value_type};
}

sub accepts {
  my ($class, $data) = @_;
  return ref($data) eq 'HASH';
}

1;
