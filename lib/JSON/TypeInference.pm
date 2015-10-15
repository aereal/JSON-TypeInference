package JSON::TypeInference;
use 5.008001;
use strict;
use warnings;

our $VERSION = "0.02";

use List::Util qw(first);
use List::UtilsBy qw(partition_by sort_by);

use JSON::TypeInference::Type::Array;
use JSON::TypeInference::Type::Boolean;
use JSON::TypeInference::Type::Null;
use JSON::TypeInference::Type::Number;
use JSON::TypeInference::Type::Object;
use JSON::TypeInference::Type::String;
use JSON::TypeInference::Type::Union;
use JSON::TypeInference::Type::Unknown;

use constant ENTITY_TYPE_CLASSES => [
  map { join '::', 'JSON::TypeInference::Type', $_ } qw( Array Boolean Null Number Object String )
];

# [Any] => Type
sub infer {
  my ($class, $dataset) = @_;
  my $dataset_by_type = { partition_by { _infer_type_for($_) } @$dataset };
  my $possible_types = [ keys %$dataset_by_type ];
  my $types = [ map {
    my $type_class = $_;
    if ($type_class eq 'JSON::TypeInference::Type::Array') {
      my $dataset = $dataset_by_type->{$type_class};
      my $elements = [ map { @$_ } @$dataset ];
      my $element_type = $class->infer($elements);
      JSON::TypeInference::Type::Array->new($element_type);
    } elsif ($type_class eq 'JSON::TypeInference::Type::Object') {
      my $dataset = $dataset_by_type->{$type_class}; # ArrayRef[HashRef[Str, Any]]
      my $keys = [ map { keys %$_ } @$dataset ]; # ArrayRef[Str]
      my $dataset_by_prop = { map {
        my $prop = $_;
        ($prop => [ map { $_->{$prop} } @$dataset ])
      } @$keys }; # HashRef[Str, ArrayRef[Str]]
      my $prop_types = { map { ($_ => $class->infer($dataset_by_prop->{$_})) } @$keys };
      JSON::TypeInference::Type::Object->new($prop_types);
    } else {
      ($type_class // 'JSON::TypeInference::Type::Unknown')->new;
    }
  } @$possible_types ];
  return scalar(@$types) > 1 ? JSON::TypeInference::Type::Union->new(sort_by { $_->name } @$types) : $types->[0];
}

# Any => Type
sub _infer_type_for {
  my ($data) = @_;
  return (first { $_->accepts($data) } @{ENTITY_TYPE_CLASSES()}) // 'JSON::TypeInference::Type::Unknown';
}

1;
__END__

=encoding utf-8

=head1 NAME

JSON::TypeInference - Inferencing JSON types from given Perl values

=head1 SYNOPSIS

    use JSON::TypeInference;

    my $data = [
      { name => 'yuno' },
      { name => 'miyako' },
      { name => 'nazuna' },
      { name => 'nori' },
    ];
    my $inferred_type = JSON::TypeInference->infer($data); # object[string, string]

=head1 DESCRIPTION

JSON::TypeInference infers the type of JSON values from the given Perl values.

If some candidate types of the given Perl values are inferred, JSON::TypeInference reports the type of it as a union type that consists of all candidate types.

=head1 CLASS METHODS

=over 4

=item infer

    JSON::TypeInference->infer($dataset: ArrayRef[Any]); # => JSON::TypeInference::Type

To infer the type of JSON values from the given values.

Return value is a instance of JSON::TypeInference::Type that means the inferred JSON type.

=back

=head1 LICENSE

Copyright (C) aereal.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

aereal E<lt>aereal@aereal.orgE<gt>

=cut

