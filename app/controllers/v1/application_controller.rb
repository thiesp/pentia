class V1::ApplicationController < ApplicationController
  resource_description do
    formats ['json']
    api_version '1'
  end
end
