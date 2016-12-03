class UsersController < ApplicationController
  # DBからFindでユーザ取り出す
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
end
