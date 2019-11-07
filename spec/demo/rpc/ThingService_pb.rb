# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: rpc/ThingService.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "rpc.Thing" do
    optional :id, :uint32, 1
    optional :name, :string, 2
  end
  add_message "rpc.GetThingRequest" do
    optional :id, :uint32, 1
    optional :sleep, :uint32, 2
  end
  add_message "rpc.GetThingResponse" do
    optional :thing, :message, 1, "rpc.Thing"
  end
end

module Rpc
  Thing = Google::Protobuf::DescriptorPool.generated_pool.lookup("rpc.Thing").msgclass
  GetThingRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("rpc.GetThingRequest").msgclass
  GetThingResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("rpc.GetThingResponse").msgclass
end
