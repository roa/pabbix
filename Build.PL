#!/usr/bin/perl
use 5.010;
use feature 'say';
use warnings;

use lib 'lib';
use Module::Build;
use Getopt::Long qw(:config pass_through);

my $install      = 0;
my $dist         = 0;
my $v            = '0.01';
my @script_files = grep { -f and !-d } glob 'bin/main.pl';
say for @script_files;

GetOptions(
    'install' => \$install,
    'dist'    => \$dist,
);

my $builder = Module::Build->new(
    module_name        => 'Pabbix',
    license            => 'perl',
    dist_abstract      => 'blah',
    dist_author        => q{roa},
    dist_version_from  => 'lib/Pabbix.pm',
    build_requires     => { 'Test::More' => 0, },
    configure_requires => { 'Module::Build' => 0.38, },
    requires           => {
        'perl'            => 0,
        'LWP::UserAgent'  => 0,
        'JSON::XS'        => 0,
        'Data::Dumper'    => 0,
        'Array::Diff'     => 0,

    },
    add_to_cleanup     => ['Build _build MYMETA.*'],
    create_makefile_pl => 'traditional',

    meta_add => {
        no_index       => { directory => ['t'], },
        version        => $v,
        release_status => 'unstable',
    },
    script_files => [@script_files],
    meta_merge   => {
        provides => {
            'Pabbix' => {
                file    => 'lib/Pabbix.pm',
                version => $v,
            },
        },
    },

);

if ($dist) {
    $builder->dispatch('build');
    $builder->dispatch('test');
    $builder->dispatch('distmeta');
    $builder->dispatch('dist');
}

if ($install) {
    $builder->dispatch('build');
    $builder->dispatch( 'test', verbose => 1 );
    $builder->dispatch('install');
}

$builder->create_build_script();
