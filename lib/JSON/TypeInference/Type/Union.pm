package JSON::TypeInference::Type::Union;
use strict;
use warnings;

sub new {
  my ($class, @types) = @_;
  return bless { _types => \@types }, $class;
}

sub name {
  my ($class) = @_;
  return 'union';
}

sub types {
  my ($self) = @_;
  return $self->{_types};
}

sub accepts {
  my ($self, $data) = @_;
  return 0;
}

1;
