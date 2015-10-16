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

sub signature {
  my ($self) = @_;
  return 'string';
}

1;
__END__

=encoding utf-8

=head1 NAME

JSON::TypeInference::Type::String - JSON string type

=head1 DESCRIPTION

JSON::TypeInference::Type::String represents JSON string type.

It is a value type, and so has no parameters.

=head1 AUTHOR

aereal E<lt>aereal@aereal.orgE<gt>

=cut

