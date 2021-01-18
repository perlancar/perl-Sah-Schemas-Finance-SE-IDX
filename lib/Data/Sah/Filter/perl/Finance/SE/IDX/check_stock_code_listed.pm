package Data::Sah::Filter::perl::Finance::SE::IDX::check_stock_code_listed;

# AUTHORITY
# DATE
# DIST
# VERSION

use 5.010001;
use strict;
use warnings;

sub meta {
    +{
        v => 1,
        summary => 'Check that a stock code is listed',
        might_fail => 1,
    };
}

sub filter {
    my %args = @_;

    my $dt = $args{data_term};

    my $res = {};

    $res->{modules}{"Finance::SE::IDX::Static"} //= 0.006;

    $res->{expr_filter} = join(
        "",
        "do { my \$tmp = uc($dt); my \$ret; ",

        # since we are performed early before other clauses like len=4, we might
        # as well check the syntax of stock code here and provide a more
        # meaningful error message
        "  if (length \$tmp != 4 || \$tmp !~ /\\A[A-Z]{4}\\z/) { \$ret = [\"Stock code must be 4 letters\", \$tmp]; goto RETURN_RET } ",

        "  for my \$rec (\@{ \$Finance::SE::IDX::Static::data_stock }) { ",
        "    if (\$rec->[0] eq \$tmp) { \$ret=[undef, \$tmp]; last } ",
        "  } ",
        "\$ret ||= [\"Stock code \$tmp is not listed\", \$tmp]; ",
        "RETURN_RET: \$ret }",
    );

    $res;
}

1;
# ABSTRACT:

=for Pod::Coverage ^(meta|filter)$
