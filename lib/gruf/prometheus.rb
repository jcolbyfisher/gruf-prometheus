# frozen_string_literal: true

# Copyright (c) 2019-present, BigCommerce Pty. Ltd. All rights reserved
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
# documentation files (the "Software"), to deal in the Software without restriction, including without limitation the
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit
# persons to whom the Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the
# Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
# WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
# OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
require 'prometheus_exporter'
require 'prometheus_exporter/server'
require 'prometheus_exporter/client'
require 'prometheus_exporter/middleware'
require 'prometheus_exporter/instrumentation'
require 'gruf'
require 'net/http'
require 'logger'
require 'bigcommerce/prometheus'

require_relative 'prometheus/version'
require_relative 'prometheus/configuration'
require_relative 'prometheus/request_types'
require_relative 'prometheus/server/collector'
require_relative 'prometheus/server/interceptor'
require_relative 'prometheus/server/type_collector'
require_relative 'prometheus/client/collector'
require_relative 'prometheus/client/interceptor'
require_relative 'prometheus/client/type_collector'
require_relative 'prometheus/collector'
require_relative 'prometheus/type_collector'
require_relative 'prometheus/hook'

module Gruf
  ##
  # Base top-level gruf prometheus module
  #
  module Prometheus
    extend Configuration

    def self.client
      Bigcommerce::Prometheus::Client.instance
    end
  end
end
