package JSON::TypeInference::Type::Maybe;
use strict;
use warnings;

sub new {
  my ($class, $type) = @_;
  return bless { type => $type }, $class;
}

sub name {
  my ($class) = @_;
  return 'maybe';
}

sub type {
  my ($self) = @_;
  return $self->{type};
}

sub accepts {
  my ($class, $data) = @_;
  return 0;
}

1;
