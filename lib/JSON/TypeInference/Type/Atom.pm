package JSON::TypeInference::Type::Atom;
use strict;
use warnings;

sub new {
  my ($class) = @_;
  return bless {}, $class;
}

sub signature {
  my ($self) = @_;
  return ref($self)->name;
}

1;
