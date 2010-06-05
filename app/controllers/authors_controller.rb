class AuthorsController < ApplicationController
  def show
    @author = User.from_param(params[:id])
  end
end