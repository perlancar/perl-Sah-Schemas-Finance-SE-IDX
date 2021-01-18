package Sah::Schema::idx::listed_stock_code;

# AUTHORITY
# DATE
# DIST
# VERSION

our $schema = [str => {
    summary => 'Currently listed stock code in the Indonesian Stock Exchange',
    description => <<'_',

Code must be listed.

Will be normalized to code in uppercase.

_
    len => 4,
    match => qr/\A[A-Z]{4}\z/,
    prefilters => ['Finance::SE::IDX::check_stock_code_listed'],
    #'x.perl.coerce_rules' => ['From_str::to_upper'], # uppercasing already done by the filter
    'x.completion' => 'idx_listed_stock_code',
    examples => [
        {value=>'', valid=>0},
        {value=>'BBRI', valid=>1, validated_value=>'BBRI'},
        {value=>'bbri', valid=>1, validated_value=>'BBRI'},
        {value=>'BANKBRI', valid=>0, summary=>'Too long'},
        {value=>'KARK', valid=>0, summary=>'Not currently listed'},
    ],
}, {}];

1;
# ABSTRACT:
