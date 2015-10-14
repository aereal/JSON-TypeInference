package JSON::TypeInference;
use 5.008001;
use strict;
use warnings;

our $VERSION = "0.01";

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
      my $dataset = $dataset_by_type->{$type_class};
      my $keys = [ map { keys %$_ } @$dataset ];
      my $key_type = $class->infer($keys);
      my $values = [ map { values %$_ } @$dataset ];
      my $value_type = $class->infer($values);
      JSON::TypeInference::Type::Object->new($key_type, $value_type);
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

JSON::TypeInference - It's new $module

=head1 SYNOPSIS

    use JSON::TypeInference;

=head1 DESCRIPTION

JSON::TypeInference is ...

=head1 LICENSE

Copyright (C) aereal.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

aereal E<lt>aereal@aereal.orgE<gt>

=cut

