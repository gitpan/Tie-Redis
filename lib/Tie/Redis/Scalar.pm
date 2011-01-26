package Tie::Redis::Scalar;
BEGIN {
  $Tie::Redis::Scalar::VERSION = '0.22_1';
}

# Consider using overload instead of this maybe, could then implement things
# like ++ in terms of Redis commands.

sub TIESCALAR {
  my($class, %args) = @_;
  bless \%args, $class;
}

sub _cmd {
  my($self, $cmd, @args) = @_;
  return $self->{redis}->_cmd($cmd, $self->{key}, @args);
}

sub FETCH {
  my($self) = @_;
  $self->_cmd("get");
}

sub STORE {
  my($self, $value) = @_;
  $self->_cmd("set", $value);
}

1;


__END__
=pod

=head1 NAME

Tie::Redis::Scalar

=head1 VERSION

version 0.22_1

=head1 SYNOPSIS

=cut

=head1 NAME

Tie::Redis::Scalar - Connect a Redis key to a Perl scalar

=head1 VERSION

version 0.22_1

=head1 AUTHOR

David Leadbeater <dgl@dgl.cx>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by David Leadbeater.

This is free software; you can redistribute it and/or modify it under
the terms of the Beerware license.

=cut

