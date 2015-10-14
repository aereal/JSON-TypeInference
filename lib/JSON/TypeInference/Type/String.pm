package JSON::TypeInference::Type::String;
use strict;
use warnings;
use parent qw(JSON::TypeInference::Type);

use Scalar::Util qw(looks_like_number);

sub new {
  my ($class) = @_;
  return $class->_new(
    name => 'string',
  );
}

sub accepts {
  my ($class, $data) = @_;
  return !ref($data) && defined($data) && !looks_like_number($data);
}

1;
