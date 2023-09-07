# frozen_string_literal: true

require "sidekiq/web"
require "sidekiq/cron/web"

Rails.application.routes.draw do
  authenticate :user, ->(u) { u.admin? } do
    mount Sidekiq::Web => "/sidekiq"
  end

  namespace :admin do
    resources :iframe, only: [:index]
  end

  mount Decidim::Core::Engine => "/"
end
