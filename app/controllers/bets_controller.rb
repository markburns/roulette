class BetsController < ApplicationController
  respond_to :voice, :html
  def new
    render 'new'
  end

  def create

  end
end
