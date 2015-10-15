package JSON::TypeInference::Type::Object;
use strict;
use warnings;

sub new {
  my ($class, $properties) = @_;
  return bless { properties => $properties }, $class;
}

sub name {
  my ($class) = @_;
  return 'object';
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
