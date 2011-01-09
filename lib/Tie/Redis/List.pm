package Tie::Redis::List;
BEGIN {
  $Tie::Redis::List::VERSION = '0.2';
}

sub TIEARRAY {
  my($class, %args) = @_;
  bless \%args, $class;
}

sub _cmd {
  my($self, $cmd, @args) = @_;
  return $self->{redis}->_cmd($cmd, $self->{key}, @args);
}

sub FETCH {
  my($self, $i) = @_;
  $self->_cmd(lindex => $i);
}

sub FETCHSIZE {
  my($self) = @_;
  $self->_cmd("llen");
}

sub PUSH {
  my($self, @elements) = @_;
  $self->_cmd(rpush => $_) for @elements;
}

sub EXTEND {
}

sub STORE {
  my($self, $index, $value) = @_;
  my $len = $self->_cmd("llen");
  if($index >= $len) {
    while($index > $len) {
      $self->_cmd(rpush => "");
      $len++;
    }
    $self->_cmd(rpush => $value);
  } else {
    $self->_cmd(lset => $index, $value);
  }
}

sub CLEAR {
  my($self) = @_;
  $self->_cmd("del");
}

1;


__END__
=pod

=head1 NAME

Tie::Redis::List

=head1 VERSION

version 0.2

=head1 SYNOPSIS

=cut

=head1 NAME

Tie::Redis::List - Connect a Redis list to a Perl array

=head1 VERSION

version 0.2

=head1 AUTHOR

David Leadbeater <dgl@dgl.cx>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by David Leadbeater.

This is free software; you can redistribute it and/or modify it under
the terms of the Beerware license.

=cut

