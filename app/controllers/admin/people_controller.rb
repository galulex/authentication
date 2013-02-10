class Admin::PeopleController < ApplicationController

  def index
    @people = current_user.company.users
  end

end
