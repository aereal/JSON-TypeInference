package JSON::TypeInference::Type::Number;
use strict;
use warnings;
use parent qw(JSON::TypeInference::Type::Base);

use Scalar::Util qw(looks_like_number);

sub new {
  my ($class) = @_;
  return $class->_new(name => 'number');
}

sub accepts {
  my ($class, $data) = @_;
  return !ref($data) && defined($data) && looks_like_number($data);
}

1;
