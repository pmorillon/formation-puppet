# init.pp

import 'collectd.pp'

class {
  'collectd':
    www => true;
}

