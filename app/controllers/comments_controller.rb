class CommentsController < ApplicationController
  
  # authenticate_user! ejecuta acción solo si sesión existe
  before_filter :authenticate_user!, :except => [ :index, :show ]

  # GET /comments
  # GET /comments.json
  def index
    @site = Site.find(params[:site_id])
    @comments = @site.comments
    @comment = current_user.comments.build

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = current_user.comments.build
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = current_user.comments.find(params[:id])
    @site = @comment.site
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = current_user.comments.build(params[:comment])
    @site = @comment.site

    respond_to do |format|
      if @comment.save
        format.html { redirect_to site_path(@site), notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @comment = current_user.comments.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to site_path(@comment.site), notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = current_user.comments.find(params[:id])
    site = @comment.site
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to site_path(site) }
      format.json { head :no_content }
    end
  end
end
