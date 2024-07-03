# frozen_string_literal: true

class LinksController < ApplicationController
  rescue_from(ActiveRecord::RecordNotFound) { render 'not_found_error' }

  def show
    @link = Link.find_by!(code: params[:code])
  end
end
