class Admin::PeopleController < AdminsController

  def index
    @people = current_user.company.users.page(params[:page])
  end

end
