package JSON::TypeInference;
use 5.008001;
use strict;
use warnings;

our $VERSION = "0.01";

use List::Util qw(first);

use JSON::TypeInference::Type::Array;
use JSON::TypeInference::Type::Boolean;
use JSON::TypeInference::Type::Null;
use JSON::TypeInference::Type::Number;
use JSON::TypeInference::Type::Object;
use JSON::TypeInference::Type::String;
use JSON::TypeInference::Type::Unknown;

use constant ENTITY_TYPE_CLASSES => [
  map { join '::', 'JSON::TypeInference::Type', $_ } qw( Array Boolean Null Number Object String )
];

# [Any] => Type
sub deduce {
  my ($class, $dataset) = @_;
  my $possibles = _search_possibles($dataset);
  my ($type_class) = @$possibles; # TODO
  if ($type_class eq 'JSON::TypeInference::Type::Array') {
    my $elements = [ map { @$_ } @$dataset ];
    my $element_type = $class->deduce($elements);
    return JSON::TypeInference::Type::Array->new($element_type);
  } else {
    return ($type_class // 'JSON::TypeInference::Type::Unknown')->new;
  }
}

# [Any] => [Type]
sub _search_possibles {
  my ($dataset) = @_;
  return [ map {
    my $data = $_;
    first { $_->accepts($data) } @{ENTITY_TYPE_CLASSES()};
  } @$dataset ];
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

