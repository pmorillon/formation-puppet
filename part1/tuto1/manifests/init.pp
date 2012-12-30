# init.pp

file {
  '/tmp/test1':
    ensure  => file,
    mode    => 644, owner => root, group => root,
    content => "test1\n";
  '/tmp/dir1':
    ensure  => directory,
    mode    => 755, owner => root, group => root;
  '/tmp/dir1/test2':
    ensure  => link,
    target  => '/tmp/test1';
}

