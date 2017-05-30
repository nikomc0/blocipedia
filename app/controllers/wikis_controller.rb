class WikisController < ApplicationController
  before_action :authenticate_user!

  def index
    @wiki = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])

    if @wiki.private && current_user.standard?
      flash[:alert] = "You must be a premium member to view this Wiki."
      redirect_to wikis_path
    end
  end

  def new
    @wiki = Wiki.new
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def create
    @wiki = Wiki.new
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]
    @wiki.user_id = current_user.id

    if @wiki.save
      flash[:notice] = "Wiki was created."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki."
      render :edit
    end
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]

    if @wiki.save
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    if @wiki.destroy
      flash[:notice] = "Wiki was deleted."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was a problem deleting the wiki. Please try again."
      render :edit
    end
  end
end
