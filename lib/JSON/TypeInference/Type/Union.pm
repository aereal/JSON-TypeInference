package JSON::TypeInference::Type::Union;
use strict;
use warnings;
use parent qw(JSON::TypeInference::Type::Base);

sub new {
  my ($class, @types) = @_;
  return $class->_new(name => 'union', _types => \@types);
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
