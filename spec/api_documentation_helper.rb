require 'rails_helper'
require 'rspec_api_documentation/dsl'

module RspecApiDocumentation::DSL
  module Endpoint
    def sign_in
      user ||= User.create!(email: 'spec_test_helper@qq.com', password: '123456', password_confirmation: '123456')
      no_doc do
        client.post '/sessions', {email: user.email, password: user.password}
      end
      user
    end
  end
end
