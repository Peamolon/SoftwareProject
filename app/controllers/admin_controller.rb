require 'csv'
class AdminController < ApplicationController
  before_action :authenticate_user!, :except => [:export]

  def index
    @teams = Team.all
  end

  def export
    @users = User.all.order(created_at: :desc)
    respond_to do |format|
      format.csv { send_data @users.to_csv }
    end

  end
end

