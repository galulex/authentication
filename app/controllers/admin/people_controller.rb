class Admin::PeopleController < ApplicationController

  def index
    @people = current_user.company.users.page(params[:page])
  end

end
