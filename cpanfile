requires 'perl', '5.008001';

requires 'List::Util';
requires 'Scalar::Util';

on 'test' => sub {
    requires 'Test::More', '0.98';
};

