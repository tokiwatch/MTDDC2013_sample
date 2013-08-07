#!/usr/bin/perl -w

use strict;
use Data::Dumper;
use Dancer;
use Plack::Runner;

use lib 'lib','extlib';

set serializer => 'JSON';

use MT;
my $mt = MT->new;

get '/:b_id' => sub {
    my %t = ( blog_id => param('b_id'));
    my @es = MT->model('entry')->load(\%t);
    my @r;
    foreach my $e (@es){
        my %f = (
                entry_id    => $e->id,
                entry_title => $e->title);
        push(@r, \%f);
    }
    \@r;
};

my $app = sub {
    my $env = shift;
    my $request = Dancer::Request->new ( env => $env ) ;
    Dancer->dance($request);
};

Plack::Runner->run($app);

