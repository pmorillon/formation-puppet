# init.pp

import "apache.pp"
import "collectd.pp"
import "collectd/www.pp"

include collectd::www

