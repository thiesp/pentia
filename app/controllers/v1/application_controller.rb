class V1::ApplicationController < ApplicationController
  respond_to :json
  resource_description do
    formats ['json']
    api_version '1'
  end
end
