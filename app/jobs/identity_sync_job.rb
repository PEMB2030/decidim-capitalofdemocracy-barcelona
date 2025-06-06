# frozen_string_literal: true

class IdentitySyncJob < ApplicationJob
  def perform(provider, assembly_slug)
    puts "#{provider}, #{assembly_slug}" # rubocop:disable Rails/Output
  end
end
