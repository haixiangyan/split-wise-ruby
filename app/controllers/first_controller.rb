class FirstController < ApplicationController
  def hello
    # render plain: 'Hello'
    # render json: {name: 'frank', age: 18}
    @xxx = '这是实例'
    render 'first/hello'
  end

  def hi
    render 'first/hi'
  end
end
