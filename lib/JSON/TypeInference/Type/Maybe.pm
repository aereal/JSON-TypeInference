package JSON::TypeInference::Type::Maybe;
use strict;
use warnings;

sub new {
  my ($class, $type) = @_;
  return bless { type => $type }, $class;
}

sub name {
  my ($class) = @_;
  return 'maybe';
}

sub type {
  my ($self) = @_;
  return $self->{type};
}

sub accepts {
  my ($class, $data) = @_;
  return 0;
}

1;
__END__

=encoding utf-8

=head1 NAME

JSON::TypeInference::Type::Maybe - maybe type

=head1 DESCRIPTION

JSON::TypeInference::Type::Maybe represents a possibility whether a value type exists or not.

The type consists of a value type and C<< JSON::TypeInference::Type::Null >>.

It is a container type, and has a type parameter.

=head1 AUTHOR

aereal E<lt>aereal@aereal.orgE<gt>

=cut

