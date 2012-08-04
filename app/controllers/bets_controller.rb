class BetsController < ApplicationController
  respond_to :xml, :html
  def new
    render 'new'
  end

  def create

  end
end
