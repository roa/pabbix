# Note: this file was auto-generated by Module::Build::Compat version 0.40
use ExtUtils::MakeMaker;
WriteMakefile
(
  'NAME' => 'Pabbix',
  'VERSION_FROM' => 'lib/Pabbix.pm',
  'PREREQ_PM' => {
                   'Array::Diff' => 0,
                   'Data::Dumper' => 0,
                   'JSON::XS' => 0,
                   'LWP::UserAgent' => 0,
                   'Moo' => 0,
                   'Test::More' => 0
                 },
  'INSTALLDIRS' => 'site',
  'EXE_FILES' => [
                   'bin/main.pl'
                 ],
  'PL_FILES' => {}
)
;
