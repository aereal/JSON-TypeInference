package JSON::TypeInference::Type::Base;
use strict;
use warnings;

sub _new {
  my ($class, %args) = @_;
  return bless \%args, $class;
}

sub name {
  my ($self) = @_;
  return $self->{name};
}

sub accepts {
  die 'Not implemented';
}

1;
