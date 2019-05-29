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
module Gruf
  module Prometheus
    ##
    # Hook for implementing prometheus stats before a gruf server starts
    #
    class Hook < Gruf::Hooks::Base
      ##
      # Startup the instrumentors for collection of gRPC and process metrics prior to server start
      #
      # @param [Gruf::Server] server
      #
      def before_server_start(server:)
        start_collectors(server: server)
        prometheus_server.add_type_collector(Gruf::Prometheus::TypeCollectors::Grpc)
        prometheus_server.start
      rescue StandardError => e
        logger.error "[gruf-prometheus][#{::Gruf::Prometheus.process_name}] Failed to start gruf instrumentation - #{e.message} - #{e.backtrace[0..4].join("\n")}"
      end

      ##
      # Handle proper shutdown of the prometheus server
      #
      def after_server_stop(server:)
        logger.debug "[gruf-prometheus][#{::Gruf::Prometheus.process_name}] Stopping #{server.class}"
        prometheus_server.stop
      rescue StandardError => e
        logger.error "[gruf-prometheus][#{::Gruf::Prometheus.process_name}] Failed to stop gruf instrumentation - #{e.message} - #{e.backtrace[0..4].join("\n")}"
      end

      private

      ##
      # Start collectors for the gRPC process
      #
      def start_collectors(server:)
        ::PrometheusExporter::Instrumentation::Process.start(
          type: ::Gruf::Prometheus.process_label,
          client: ::Gruf::Prometheus.client,
          frequency: ::Gruf::Prometheus.collection_frequency
        )
        ::Gruf::Prometheus::Collectors::Grpc.start(
          server: server,
          client: ::Gruf::Prometheus.client,
          frequency: ::Gruf::Prometheus.collection_frequency
        )
      end

      ##
      # @return [Gruf::Prometheus::Server]
      #
      def prometheus_server
        @prometheus_server ||= ::Gruf::Prometheus::Server.new(
          port: Gruf::Prometheus.server_port,
          timeout: Gruf::Prometheus.server_timeout,
          prefix: Gruf::Prometheus.server_prefix,
          verbose: Gruf::Prometheus.server_verbose
        )
      end
    end
  end
end
