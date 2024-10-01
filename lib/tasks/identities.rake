# frozen_string_literal: true

# require_relative "../../app/jobs/identity_sync_job"

namespace :colabs do
  namespace :identity do
    desc "Syncronize users with an identity provider as members of an assembly"
    task :sync do
      
      IdentitySyncJob.perform_now("test")
    end
  end
end