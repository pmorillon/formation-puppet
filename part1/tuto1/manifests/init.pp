# init.pp

File {
  owner => root, group => root
}

file {
  '/tmp/test1':
    ensure  => file,
    mode    => 644,
    content => "test1\n";
  '/tmp/dir1':
    ensure  => directory,
    mode    => 755;
  '/tmp/dir1/test2':
    ensure  => '/tmp/test1';
}

