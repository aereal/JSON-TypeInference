package JSON::TypeInference::Type::Null;
use strict;
use warnings;

sub new {
  my ($class) = @_;
  return bless {}, $class;
}

sub name {
  my ($class) = @_;
  return 'null';
}

sub accepts {
  my ($class, $data) = @_;
  return !defined($data);
}

1;
