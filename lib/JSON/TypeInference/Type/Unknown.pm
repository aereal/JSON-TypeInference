package JSON::TypeInference::Type::Unknown;
use strict;
use warnings;

sub new {
  my ($class) = @_;
  return bless {}, $class;
}

sub name {
  my ($class) = @_;
  return 'unknown';
}

sub accepts {
  my ($class, $data) = @_;
  return 0;
}

1;
