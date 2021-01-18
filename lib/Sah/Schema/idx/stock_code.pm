package Sah::Schema::idx::stock_code;

# AUTHORITY
# DATE
# DIST
# VERSION

our $schema = [str => {
    summary => 'Stock code in the Indonesian Stock Exchange',
    description => <<'_',

Code will not be checked whether it exists or listed.

Will be normalized to code in uppercase.

_
    len => 4,
    'x.perl.coerce_rules' => ['From_str::to_upper'],
    'x.completion' => 'idx_listed_stock_code',
    examples => [
        {value=>'', valid=>0},
        {value=>'BBRI', valid=>1, validated_value=>'BBRI'},
        {value=>'bbri', valid=>1, validated_value=>'BBRI'},
        {value=>'BANKBRI', valid=>0, summary=>'Too long'},
        {value=>'KARK', valid=>1, summary=>'Not currently listed, but still accepted'},
    ],
}, {}];

1;
# ABSTRACT:
