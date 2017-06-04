class CollaboratorsController < ApplicationController
  def new
    @collaborator = Collaborator.new
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.new(wiki_id: @wiki.id, user_id: params[:user_id])

    if @collaborator.save
      flash[:notice] = "Collaborator was added to this wiki."
      redirect_to edit_wiki_path(@wiki)
    else
      flash[:error] = "Collaborator was not added. Please try again."
      render :show
    end
  end

  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.find(params[:id])

    if @collaborator.destroy
      flash[:notice] = "Collaborator was removed from this wiki."
      redirect_to edit_wiki_path(@wiki)
    else
      flash[:error] = "Collaborator was not removed. Please try again."
      render :show
    end
  end
end
