# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Show link', type: :request do
  context 'when link exists' do
    it 'renders the correct template' do
      link = create(:link)

      get links_path(link.code)

      expect(response).to render_template(:show)
      expect(response.body).to include(link.original_url)
    end
  end

  context 'when link does not exist' do
    it 'renders the not found error page' do
      get links_path('not_found')

      expect(response).to render_template(:not_found_error)
      expect(response.body).to include('Unable to find this link')
    end
  end
end
