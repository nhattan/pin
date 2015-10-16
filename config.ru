# This file is used by Rack-based servers to start the application.

# Unicorn self-process killer
require 'unicorn/worker_killer'

# Max requests per worker
use Unicorn::WorkerKiller::MaxRequests, 200, 300, true

# Max memory size (RSS) per worker
use Unicorn::WorkerKiller::Oom, (100*(1024**2)), (150*(1024**2)), 16, true

require ::File.expand_path('../config/environment', __FILE__)
run Rails.application
