class CollaborationsController < ApplicationController
  def create
    @wiki = Wiki.find(params[:wiki_id])
    @user = User.where(:username => params[:search]).first

    if @user
      @collaboration = Collaboration.new(wiki: @wiki, user: @user)
      if @collaboration.save
        flash[:notice] = "User successfully added to wiki."
      else
        flash[:error] = "There was a problem adding user. Please try again"
      end
    else
      flash[:error] = "Sorry that wasn't a valid username. Please try again."
    end
    redirect_to @wiki
  end

  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    @collaboration = Collaboration.find(params[:id])
    if @collaboration.destroy
       flash[:notice] = "Member removed from wiki."
    else
      flash[:error] = "There was an error removing user."
    end
    redirect_to @wiki
  end

end
