# frozen_string_literal: true

Rails.application.routes.draw do
  get '/:code', to: 'links#show', as: 'links'
end
