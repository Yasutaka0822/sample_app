class UsersController < ApplicationController
  # DBからFindでユーザ取り出す
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  #ユーザ登録の失敗に対応できるcreateアクション
  def create
    @user = User.new(params[:user])
    if @user.save
      #handle a successful save.
    else
      render 'new'
    end
  end
end
