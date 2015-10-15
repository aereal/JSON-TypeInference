package JSON::TypeInference::Type::String;
use strict;
use warnings;

use Scalar::Util qw(looks_like_number);

sub new {
  my ($class) = @_;
  return bless {}, $class;
}

sub name {
  my ($class) = @_;
  return 'string';
}

sub accepts {
  my ($class, $data) = @_;
  return !ref($data) && defined($data) && !looks_like_number($data);
}

1;
