package JSON::TypeInference::Type::Number;
use strict;
use warnings;
use parent qw(JSON::TypeInference::Type::Atom);

use Scalar::Util qw(looks_like_number);

sub name {
  my ($class) = @_;
  return 'number';
}

sub accepts {
  my ($class, $data) = @_;
  return !ref($data) && defined($data) && looks_like_number($data);
}

1;
__END__

=encoding utf-8

=head1 NAME

JSON::TypeInference::Type::Number - JSON number type

=head1 DESCRIPTION

C< JSON::TypeInference::Type::Number > represents JSON number type.

It is a value type, and so has no parameters.

=head1 AUTHOR

aereal E<lt>aereal@aereal.orgE<gt>

=cut

